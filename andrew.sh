#!/bin/sh

cd ~/corewar/corewar
make

rm result.txt result2.txt

cycle=5500

rm_color () {
	sed 's/\^\[\[0m//g' $1 > result.txt
	sed 's/\[3[321]m//g' result.txt > $1
	sed '1,/0x0000 :/d' $1 > result.txt
	sed 's/\^\[//g' result.txt > $1
	sed 's/.$/ /g' $1 > result.txt
}

while test $cycle != 12500
	do
	./corewar -d $cycle -n -1 ../champion/Fuck_Eat_Repeat.cor \
			   -n -2 ../ressources/champs/Gagnant.cor \
			   -n -3 ../ressources/champs/Octobre_Rouge_V4.2.cor > result.txt
	cat -e result.txt > result2.txt
	rm_color result2.txt

	./../ressources/corewar -d $cycle -v 0 ../champion/Fuck_Eat_Repeat.cor \
	 									  ../ressources/champs/Gagnant.cor \
										  ../ressources/champs/Octobre_Rouge_V4.2.cor > result3.txt

	sed '1,/0x0000 :/d' result3.txt > result2.txt
	rm result3.txt
	diff result.txt result2.txt > check
	if [[ -s check ]] ; then
		./../ressources/corewar -d $cycle -v 2 ../champion/Fuck_Eat_Repeat.cor \
											  ../ressources/champs/Gagnant.cor \
											  ../ressources/champs/Octobre_Rouge_V4.2.cor
	fi ;
	cycle=$(($cycle + 100))
done
