#!/bin/bash -x

echo "Welcome To Gambling Simulator"

stake=100;
bet=1;

result=$(($RANDOM%2))

if [[ $result -eq 1 ]]
then
	echo "You won 1 dollar"
	total=$(($stake+1))
else
	echo "You lost 1 dollar"
	total=$(($stake-1))
fi


