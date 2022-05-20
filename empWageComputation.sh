#! /bin/bash -x

IS_PRESENT=1
IS_ABSENT=0
IS_PARTTIME=2
randomValue=0
presentAbsent=-1
TOTAL_WORKING_HOUR=8
TOTAL_WORKING_HOUR_PART_TIME=8
WAGE_PER_HOUR_FULL_DAY=20
totalWageForDay=0
NUMBER_OF_DAYS=20
totalWagePerMonth=0

echo "Welcome to emp wage"

while [ $NUMBER_OF_DAYS -ne 0 ]
do
randomValue=$((RANDOM))
presentAbsent=$(($randomValue%3))

case $presentAbsent in
	$IS_PRESENT)
	        echo "Emp present"
	        totalWageForDay=$(($TOTAL_WORKING_HOUR*$WAGE_PER_HOUR_FULL_DAY));;
	$IS_ABSENT)
	        echo "Emp absent"
	        totalWageForDay=0;;
	$IS_PARTTIME)
	        echo "Emp partTime"
	        totalWageForDay=$(($TOTAL_WORKING_HOUR_PART_TIME*$WAGE_PER_HOUR_FULL_DAY));;
	*)
		echo "Work response"
esac

totalWagePerMonth=$(( $totalWagePerMonth + $totalWageForDay ))
((NUMBER_OF_DAYS--))
done
echo $totalWagePerMonth
