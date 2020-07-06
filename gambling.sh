#!/bin/bash

echo "Welcome To Gambling Simulator"

declare -A dailyAmount

stake=100;
bet=1;
stakePercentage=$(($((stake/100))*50))
maxWin=$((stake+stakePercentage));
maxLose=$((stake-stakePercentage));
maxDays=20;
totalBetAmt=$((stake*maxDays))

TOTAL_PER_DAY=$((stake));
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
	if [[ $FINAL_AMOUNT -gt $totalBetAmt ]]
	then
		echo "AT THE END OF 20 DAYS, YOU WON $"$(($FINAL_AMOUNT-$totalBetAmt))
	else
		echo "AT THE END OF 20 DAYS, YOU LOST $"$(($totalBetAmt-$FINAL_AMOUNT))
	fi
}

totalAmount
printDailyAmt
winOrLose

