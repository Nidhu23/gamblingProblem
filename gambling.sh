#!/bin/bash -x

echo "Welcome To Gambling Simulator"

stake=100;
bet=1;
maxWin=150;
maxLose=50;

total=$((stake));

while [[ $total -le $maxWin && $total -ge $maxLose ]]
do
	result=$(($RANDOM%2))
	if [[ $result -eq 1 ]]
	then
		echo "You won 1 dollar"
		((total++))
	else
		echo "You lost 1 dollar"
		((total--))
	fi
done

