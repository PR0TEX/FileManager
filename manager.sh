#!/bin/bash

UW="ulozenie wszystkich"
KK="kopiowanie konkretnego"
KW="kopiowanie wszystkich"
PL="Podaj lokalizacje"
PK="przeniesienie konkretnego"
PW="przeniesienie wszystkich"
DKL="do konkretnej lokalizacji"
POLECENIE=
WYBOR=
LOK=
NAZWA=
ROZ="*"
CEL=
SEP=
prawo=("odczytu" "zapisu" "wykonania");
VAL=(0 0 0);
IL=
SUM=
GR=
MOD=
KOD=""


until [[ $POLECENIE = "q" ]]; do
	echo "Wybierz opcje: "
	echo "1 - usuwanie"
	echo "2 - przenoszenie"
	echo "3 - kopiowanie"
	echo "4 - modyfikowanie"
	echo "5 - grupowanie"
	echo "q - koniec"
	read POLECENIE

	case $POLECENIE in

		"1") 
			echo "Co chcesz usunac ?"
			echo "k - katalog"
			echo "p - plik"
			read WYBOR
				if [[ $WYBOR = "p" ]]; then
					echo "Podaj nazwe pliku"
					read NAZWA
					echo "Podaj lokalizacje pliku"
					read LOK
					echo "Podaj rozszerzenie pliku, w przeciwnym wypadku wpisz n"
					read WYBOR
					if [[ $WYBOR != "n" ]]; then
						ROZ=$WYBOR
					fi
					find $LOK -maxdepth 1 -type f -name "$NAZWA"."$ROZ" | xargs -r rm -v
				elif [[ $WYBOR = "k" ]]; then
					echo "Podaj lokalizacje katalogu"
					read LOK
					echo "Podaj nazwe katalogu"
					read NAZWA
					find $LOK/ -maxdepth 1 -type d -name "$NAZWA" | xargs -r rm -rv
				fi ;;
		"2") 
			echo "Wybierz opcje"
			echo "1 - $PW elementow $DKL"
			echo "2 - $PW plikow $DKL"
			echo "3 - $PW katalogow $DKL"
			echo "4 - $PK pliku $DKL"
			echo "5 - $PK katalogu $DKL"
			read WYBOR
			case $WYBOR in
			
				"1")
					echo "$PL elementow"
					read LOK
					echo "$PL docelowa"
					read CEL
					mv -v $LOK/* $CEL/
				;;
				"2")
					echo "$PL plikow"
					read LOK
					echo "$PL docelowa"
					read CEL
					find $LOK/ -maxdepth 1 -type f -exec mv -v {} $CEL/ \;
				;;
				"3")
					echo "$PL katalogow"
					read LOK
					echo "$PL docelowa"
					read CEL
					find $LOK -mindepth 1 -maxdepth 1 -type d | xargs -r mv -tv $CEL \;
				;;
				"4")
					echo "Podaj nazwe pliku"
					read NAZWA
					echo "$PL pliku"
					read LOK
					echo "$PL docelowa"
					read CEL
					find $LOK -maxdepth 1 -type f -name "$NAZWA" -exec mv -v {} $CEL/ \;
				;;
				"5")
					echo "Podaj nazwe katalogu"
					read NAZWA
					echo "$PL katalogu"
					read LOK
					echo "$PL docelowa"
					read CEL
					find $LOK -mindepth 1 -maxdepth 1  -type d -name "$NAZWA" | xargs -r mv -t $CEL/
				;;
			esac
		
		;;
		"3") 
			echo "Wybierz opcje"
			echo "1 - $KW elementow $DKL"
			echo "2 - $KW plikow $DKL"
			echo "3 - $KW katalogow $DKL"
			echo "4 - $KK pliku $DKL"
			echo "5 - $KK katalogu $DKL"
			read WYBOR
			case $WYBOR in
				"1")
					echo "$PL elementow"
					read LOK
					echo "$PL docelowa"
					read CEL
					cp -rv $LOK/* $CEL/
				;;
				"2")
					echo "$PL plikow"
					read LOK
					echo "$PL docelowa"
					read CEL
					find $LOK/ -maxdepth 1 -type f -exec cp -v {} $CEL/ \;
				;;
				"3")
					echo "$PL katalogow"
					read LOK
					echo "$PL docelowa"
					read CEL
					find $LOK/ -mindepth 1 -maxdepth 1 -type d -exec cp -rv {} $CEL/ \;
				;;
				"4")
					echo "Podaj nazwe pliku"
					read NAZWA
					echo "$PL pliku"
					read LOK
					echo "$PL docelowa"
					read CEL
					find $LOK -type f -name "$NAZWA" -exec cp -v {} $CEL/ \;
				;;
				"5")
					echo "Podaj nazwe katalogu"
					read NAZWA
					echo "$PL katalogu"
					read LOK
					echo "$PL docelowa"
					read CEL
					cp -rv $LOK/$NAZWA $CEL
				;;
			esac
			
		;;
		"4")
			echo "Wybierz opcje"
			echo "1-Zmiana nazwy"
			echo "2-Zamiana tekstu w pliku"
			echo "3-Zmiana rozszerzenia"
			echo "4-Zmiana praw dostepu"
			read WYBOR
			
			case $WYBOR in
				
				"1")
					echo "n-zmiana calej nazwy"
					echo "l-zamiana malych liter na wielkie"
					echo "b-zamiana wielkich liter na male"
					echo "s-zamiana separatorow wyrazow"
					read WYBOR
					
					if [[ $WYBOR = "n" ]]; then
						echo -e "k-katalog \np-plik"
						read WYBOR
						echo "Podaj folder nadrzedny"
						read LOK
						echo "Podaj aktualna nazwe"
						read NAZWA
						echo "Podaj nowa nazwa"
						read CEL
						if [[ $WYBOR = "p" ]]; then
							mv $LOK/$NAZWA $LOK/$CEL
						elif [[ $WYBOR = "k" ]]; then
							mv $LOK/$NAZWA $LOK/$CEL
						fi
					elif [[ $WYBOR = "l" ]]; then
						echo "Podaj folder nadrzedny"
						read LOK
						echo "Podaj nazwe"
						read NAZWA
						CEL="$(echo $NAZWA | tr '[:lower:]' '[:upper:]')"
						mv $LOK/$NAZWA $LOK/$CEL
					elif [[ $WYBOR = "b" ]]; then 
						echo "Podaj folder nadrzedny"
						read LOK
						echo "Podaj nazwe"
						read NAZWA
						CEL="$(echo $NAZWA | tr '[:upper:]' '[:lower:]')"
						mv $LOK/$NAZWA $LOK/$CEL
					elif [[ $WYBOR = "s" ]]; then
						echo "Podaj folder nadrzedny"
						read LOK
						echo "Podaj nazwe"
						read NAZWA
						echo "Podaj separator"
						read -r SEP
						echo "Na jaki separator zmienic ?"
						read -r CEL
						rename "s/"$SEP"/"$CEL"/g" $LOK/$NAZWA
					fi
				;;
				"2")
					echo "Podaj lokalizacje pliku"
					read LOK
					echo "Podaj nazwe pliku"
					read NAZWA
					echo "Podaj co chcesz zmienic"
					read WYBOR
					echo "Podaj na co chcesz zmienic"
					read -r CEL
					sed -e "s/"$WYBOR"/"$CEL"/" $LOK"/"$NAZWA
				;;
				"3")
					echo "Podaj lokalizacje pliku"
					read LOK
					echo -e "Wybierz:\nw-wszystkie pliki\nk-konkretny plik"
					read WYBOR
					echo "Podaj nowe rozszerzenie"
					read CEL
					if [[ $WYBOR = "w" ]]; then
						echo "Podaj stare rozszerzenie"
						read ROZ
						for a in $LOK/*.$ROZ; do mv $a $LOK/`basename $a .$ROZ`.$CEL;done
					elif [[ $WYBOR = "k" ]]; then
						echo "Podaj nazwe pliku"
						read NAZWA
						mv $LOK/$NAZWA $LOK/`basename $NAZWA .${NAZWA#*.}`.$CEL
					fi
				;;
				"4")
					echo "Dla ilu grup chcesz modyfikowac ?"
					read IL
						for (( i=0; i<$IL; i++ ))
						do
							echo -e "Dla kogo \nw-wlasciciel\ng-grupa\na-wszyscy"
							read GR
							for (( j=0; j<3; j++ ))
							do
								echo -e "Prawo do "${prawo[$j]}" dla grupy "$GR "\n1-tak\n0-nie"
								read
								if [[ $REPLY -eq 1 ]]; then
									if [[ $GR = "w" ]]; then
										SUM=0
									elif [[ $GR = "g" ]]; then
										SUM=1
									else SUM=2
									fi
									if [[ $j -eq 0 ]]; then
										MOD=4
									elif [[ $j -eq 1 ]]; then
										MOD=2
									else MOD=1
									fi
									VAL[$SUM]=`expr ${VAL[$SUM]} + $MOD`	
								fi
							done
						done
					for i in "${VAL[*]}"
					do
						KOD+=$i
					done
					KOD=${KOD// /}
					echo "Lokalizacja pliku"
					read LOK
					echo "Nazwa pliku/katalogu"
					read NAZWA
					chmod $KOD $LOK/$NAZWA
		;;
		esac
		;;
		"5")
			echo "Podaj lokalizacje"
			read LOK
			echo "Wybierz co chcesz zrobic"
			echo "1-$UW elementow"
			echo "2-$UW plikow"
			echo "3-$UW katalogow"
			read WYBOR
			echo -e "Wybierz rodzaj sortowania:\nr-rozmiar\nn-nazwa"
			read SEP
			echo -e "a-rosnaco\nd-malejaco"
			read TYP
			touch $LOK/pom.txt
			
			if [[ $WYBOR = "1" ]]; then
				POLECENIE="ls $LOK"
			elif [[ $WYBOR = "2" ]]; then
				POLECENIE="ls $LOK -p | grep -v /"
			elif [[ $WYBOR = "3" ]]; then
				POLECENIE='ls "$LOK" -l | grep "^d" | sed -e "s|.*\s||"'
			fi
			if [[ $TYP = "a" ]]; then
				RODZAJ=""
			elif [[ $TYP = "d" ]]; then
				RODZAJ="-r"
			fi
							if [[ $SEP = "n" ]]; then
								if [[ $TYP = "a" ]]; then
									eval $POLECENIE | sort > $LOK/pom.txt
								elif [[ $TYP = "d" ]]; then
									echo "malo"
									eval $POLECENIE | sort -r > $LOK/pom.txt
								fi
							elif [[ $SEP = "r" ]]; then 
								if [[ $WYBOR = "2" ]]; then
									ls $LOK -Sp $RODZAJ | grep -v / > $LOK/pom.txt
								elif [[ $WYBOR = "3" ]]; then
									ls $LOK -Sl $RODZAJ | grep '^d' | sed -e 's|.*/s||'
								else $POLECENIE -S $RODZAJ > $LOK/pom.txt
								fi
					fi
			echo -e "Podaj nazwe folderu"
			read NAZWA
			mkdir $LOK/$NAZWA
			for PLIK in `cat $LOK/pom.txt`
			do
				mv $LOK/$PLIK $LOK/$NAZWA/$PLIK
			done
			if [[ $WYBOR = "1" || $WYBOR = "2" ]]; then 
				rm $LOK/$NAZWA/pom.txt
			else rm $LOK/pom.txt	
			fi
			
		;;
	esac
done
