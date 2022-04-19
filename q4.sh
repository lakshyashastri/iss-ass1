#!/bin/bash

read input
# 21,22,34,1,7,90,101,2,4,8,45

arr=( `echo $input | tr "," " "` )

arr_len=${#arr[@]}

for (( i=0; i<$arr_len; i++ )); do
    for (( j=0; j<$arr_len-i-1; j++ )); do
        if [[ ${arr[j]} -gt ${arr[$(( j+1 ))]} ]]; then
            temp=${arr[j]}
            arr[$j]=${arr[$(( j+1 ))]}
            arr[$(( j+1 ))]=$temp
        fi
    done
done

echo ${arr[*]}
