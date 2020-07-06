#!/bin/bash

echo "Welcome To Gambling Simulator"

declare -A dailyAmount

stake=100;
bet=1;
maxWin=150;
maxLose=50;
maxDays=20;

TOTAL_PER_DAY=$((stake));
TOTAL_TWENTY_DAYS=0;
WON_AMOUNT=0;
LOST_AMOUNT=0;
FINAL_AMOUNT=0;

dailyCalculation(){
	while [[ $TOTAL_PER_DAY -lt $maxWin && $TOTAL_PER_DAY -gt $maxLose ]]
	do
		result=$(($RANDOM%2))
		if [[ $result -eq 1 ]]
		then
			((TOTAL_PER_DAY++))
		else
			((TOTAL_PER_DAY--))
		fi
	done
}

totalAmount(){
	for (( Day=1; Day<=$maxDays; Day++ ))
	do
		dailyCalculation
		dailyAmount[$Day]=$((TOTAL_PER_DAY))
		FINAL_AMOUNT=$(($FINAL_AMOUNT+$TOTAL_PER_DAY))
		TOTAL_PER_DAY=$((stake))
	done
}

printDailyAmt(){
	for ((Day=1;Day<=$maxDays;Day++))
	do
		echo -e "Final Amount On Day" $Day "\t" ${dailyAmount[$Day]} "\n"
	done
}

winOrLose(){
	if [[ $FINAL_AMOUNT -gt 2000 ]]
	then
		echo "AT THE END OF 20 DAYS, YOU WON " $(($FINAL_AMOUNT-2000))
	else
		echo "AT THE END OF 20 DAYS, YOU LOST " $((2000-$FINAL_AMOUNT))
	fi
}

totalAmount
printDailyAmt
winOrLose

