#!/bin/bash

echo "Welcome To Gambling Simulator"


INITIAL_STAKE=100;
BET=1;
MAX_DAYS=10;

totalPerDay=0
winTemp=0
loseTemp=0
winDay=0
loseDay=0
winTotal=0
loseTotal=0
month=1

unluckyCheck(){
	if [[ $loseTemp -lt $newStake ]]
	then
		loseTemp=$(($newStake))
		loseDay=$(($day))
	fi
}

luckyCheck(){
	if [[ $winTemp -lt $newStake ]]
	then
		winTemp=$(($newStake))
		winDay=$(($day))
	fi
}

dailyCalculation(){
	while [[ $totalPerDay -lt $maxWin && $totalPerDay -gt $maxLose ]]
	do
        	if [[ $(($RANDOM%2)) -eq 0 ]]
        	then
            		totalPerDay=$(($totalPerDay-$BET))
        	else
            		totalPerDay=$(($totalPerDay+$BET))
        	fi
    	done
    	if [[ $totalPerDay -gt $newStake ]]
    	then
        	if [[ $(($totalPerDay-$newStake)) -eq 1 ]]
        	then
			unluckyCheck
            		loseTotal=$(($loseTotal+$newStake))
            		echo "At the End of day $day: $totalPerDay Lost $newStake"
        	else
			luckyCheck
            		winTotal=$(($winTotal+$newStake))
            		echo "At the End of day $day: $totalPerDay won $newStake"
        	fi
    	else
		unluckyCheck
        	loseTotal=$(($loseTotal+$newStake))
        	echo "At the End of day $day: $totalPerDay Lost $newStake"
    	fi
}

totalAmount(){
	totalPerDay=$(($totalPerDay+$INITIAL_STAKE))
    	newStake=$(($totalPerDay/2))
    	maxWin=$(($totalPerDay+$newStake))
    	maxLose=$(($totalPerDay-$newStake))
	dailyCalculation
}

play(){
	for (( day=1; day<=MAX_DAYS; day++ ))
	do
		totalAmount
	done
}

print(){
	echo "Your unluckiest day is $loseDay, You lost $loseTemp"
     	echo "Your luckiest day is $winDay, You won $winTemp"
}

gameContinue(){
	while true
	do
    		if [[ $month -eq 1 ]]
    		then
        		echo "For month $month"
        		play
			print
			((month++))
    		else
        		while [[ $winTotal -gt $loseTotal ]]
        		do
            			echo "For month $month"
            			play
				print
				((month++))
        		done
			echo "You faced too much loss in month $(($month-1)), you lost $loseTotal"
                        exit
    		fi
	done
}

gameContinue
