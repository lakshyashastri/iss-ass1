#!/bin/bash  

read -r file_name
# file_name="sample2.txt"
# file_name="sample-text-file.txt"

#doing `cmd < filename` instead of just `cmd filename` removed the filename from the output
# size of bytes
du -h < $file_name

# number of lines
# cat $file_name | wc -l
# sed -n '$=' $file_name
wc -l < $file_name

# number of words
wc -w < $file_name

# number of words per line
i=1
while read line; do
    # count=echo $line | sed -n '$='
    count=$(echo $line | wc -w)
    echo "Line: $i - Count of words: $count"
    ((i=i+1))
    # break
done < $file_name

# list of repeated words
declare -A data

while read -r line; do
    # echo $line >> temp.txt # doesn't even copy all lines and words from sample2.txt
    
    words=($(echo $line | tr " " "\n")) # remove fullstops and other punctuation too: check for split line into words command
    for word in ${words[@]}; do
        if [[ -v data[$word] ]]; then 
            let data[$word]=${data[$word]}+1
        else
            data[$word]=1
        fi
        # echo $word >> temp.txt
    done

done < $file_name

for key in ${!data[@]}; do
    echo "$key: ${data[$key]}"
done
