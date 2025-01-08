#!/bin/bash
calculate() {
    local num1=$1
    local operator=$2
    local num2=$3
    case $operator in 
         +) result=$(echo "$num1 + $num2" | bc);;
         -) result=$(echo "$num1 - $num2" | bc);;
         multiply) result=$(echo "$num1 * $num2" | bc);;
         /)
           if [ "$num2" -eq 0 ]; then
             echo "not possible"
              return
           else
            result=$(echo "$num1 / $num2" | bc -l)
           fi
           ;;
        *) echo "invalid output"; return;;
    esac
    echo "Result: $result"
}
echo "Welcome to calclator"
echo "enter fist number"
read num1

echo "enter operator:"
read operator
echo "enter second number"
read num2
calculate $num1 $operator $num2