#!/bin/bash

echo "Welcome To Gambling Simulator"

declare -A dailyAmount

STAKE=100;
BET=1;
STAKE_PERCENTAGE=$(($((STAKE/100))*50))
MAX_WIN=$((STAKE+STAKE_PERCENTAGE));
MAX_LOSE=$((STAKE-STAKE_PERCENTAGE));
MAX_DAYS=20;
TOTAL_BET_AMT=$((STAKE*MAX_DAYS))

totalPerDay=$((STAKE));
finalAmt=0;

dailyCalculation(){
	while [[ $totalPerDay -lt $MAX_WIN && $totalPerDay -gt $MAX_LOSE ]]
	do
		result=$(($RANDOM%2))
		if [[ $result -eq 1 ]]
		then
			((totalPerDay++))
		else
			((totalPerDay--))
		fi
	done
}

totalAmount(){
	for (( day=1; day<=$MAX_DAYS; day++ ))
	do
		dailyCalculation
		dailyAmount[$day]=$((totalPerDay))
		finalAmt=$(($finalAmt+$totalPerDay))
		totalPerDay=$((STAKE))
	done
}

printDailyAmt(){
	for ((day=1;day<=$MAX_DAYS;day++))
	do
		echo -e "Final Amount On Day" $day "\t" ${dailyAmount[$day]} "\n"
	done
}

winOrLose(){
	if [[ $finalAmt -gt $TOTAL_BET_AMT ]]
	then
		echo "AT THE END OF 20 DAYS, YOU WON $"$(($finalAmt-$TOTAL_BET_AMT))
	else
		echo "AT THE END OF 20 DAYS, YOU LOST $"$(($TOTAL_BET_AMT-$finalAmt))
	fi
}

totalAmount
printDailyAmt
winOrLose
