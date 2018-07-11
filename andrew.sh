#!/bin/sh

EOC='\033[0m' # End Of Color
RED='\033[0;31m'
YEL='\033[1;33m'
GRE='\033[0;32m'
BLU='\033[0;34m'

echo "${BLU}Running ${RED}Androunette Corewar : ${EOC}"

cd ~/corewar/corewar #path from home to corewar exec

if [[ -s result.txt || -s result2.txt ]] ; then
	rm result.txt result2.txt
fi ;

cycle=5500 # Start Dumping...

#put 1 till 4 champion(s) path from corewar
champ1='../champion/Fuck_Eat_Repeat.cor'
champ2='../ressources/champs/Gagnant.cor'
champ3='../ressources/champs/Octobre_Rouge_V4.2.cor'
champ4=nothing

rm_color () {
	sed 's/\^\[\[0m//g' $1 > result.txt
	sed 's/\[3[321]m//g' result.txt > $1
	sed '1,/0x0000 :/d' $1 > result.txt
	sed 's/\^\[//g' result.txt > $1
	sed 's/.$/ /g' $1 > result.txt
}

while test $cycle != 12500 # End Cycle...
	do
	./corewar -d $cycle -n -1 $champ1 \
			   -n -2 $champ2 \
			   -n -3 $champ3 > result.txt
	cat -e result.txt > result2.txt
	rm_color result2.txt

	./../ressources/corewar -d $cycle -v 0 $champ1 \
	 									   $champ2 \
										   $champ3 > result3.txt

	sed '1,/0x0000 :/d' result3.txt > result2.txt
	rm result3.txt
	diff result.txt result2.txt > check
	if [[ -s check ]] ; then
		echo "${RED}KO ${EOC}cycle ${RED}$cycle${EOC}"
	fi ;
	cycle=$(($cycle + 100))
done

rm result.txt result2.txt
