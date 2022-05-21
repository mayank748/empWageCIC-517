#! /bin/bash -x

declare -A dailyWage

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
TOTAL_WORKING_HOUR_IN_MONTH=100


function calculateWage(){
	local workingHour=$1
	local wagePerHour=$2
	echo $(($workingHour*$wagePerHour))
}


echo "Welcome to emp wage"

while [ $NUMBER_OF_DAYS -ne 0 -a $TOTAL_WORKING_HOUR_IN_MONTH -gt 0 ]
do
echo "******************************new day**********************************"
randomValue=$((RANDOM))
presentAbsent=$(($randomValue%3))

if [ $TOTAL_WORKING_HOUR_IN_MONTH -lt $TOTAL_WORKING_HOUR -o $TOTAL_WORKING_HOUR_IN_MONTH -lt $TOTAL_WORKING_HOUR_PART_TIME ]
then
	if [ $presentAbsent -eq $IS_PRESENT ]
	then
		TOTAL_WORKING_HOUR=$(($TOTAL_WORKING_HOUR_IN_MONTH))
	elif [ $presentAbsent -eq $IS_PARTTIME ]
	then
		TOTAL_WORKING_HOUR_PART_TIME=$(($TOTAL_WORKING_HOUR_IN_MONTH))
	fi
fi

case $presentAbsent in
	$IS_PRESENT)
	        echo "Emp present"
		TOTAL_WORKING_HOUR_IN_MONTH=$(($TOTAL_WORKING_HOUR_IN_MONTH-$TOTAL_WORKING_HOUR))
	        totalWageForDay=`calculateWage $TOTAL_WORKING_HOUR $WAGE_PER_HOUR_FULL_DAY` ;;
	$IS_ABSENT)
	        echo "Emp absent"
	        totalWageForDay=0;;
	$IS_PARTTIME)
	        echo "Emp partTime"
		TOTAL_WORKING_HOUR_IN_MONTH=$(($TOTAL_WORKING_HOUR_IN_MONTH-$TOTAL_WORKING_HOUR_PART_TIME))
	        totalWageForDay=`calculateWage $TOTAL_WORKING_HOUR_PART_TIME $WAGE_PER_HOUR_FULL_DAY` ;;
	*)
		echo "Work response"
esac

totalWagePerMonth=$(( $totalWagePerMonth + $totalWageForDay ))
dailyWage[$NUMBER_OF_DAYS]='{ '$totalWagePerMonth' : '$totalWageForDay' }'
((NUMBER_OF_DAYS--))
echo "******************************day end**********************************"
done
echo $totalWagePerMonth
echo ${!dailyWage[@]}

echo ${dailyWage[@]}
