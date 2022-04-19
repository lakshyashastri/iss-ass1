#!/bin/bash  

src_file="quotes.txt"
new_file="new.txt"
new_file2="new2.txt"
# new_file3="new3.txt"

# content=$(<$name)

# 

# read -r $name > new.txt

# echo $content > new.txt

first=true
while IFS= read -r line; do
    # remove empty lines

    if $first && [ "$line" != "" ]; then
        echo $line > $new_file
        first=false
        continue
    fi

    if [ "$line" != "" ]; then
        echo $line >> $new_file
    fi
done < $src_file

dupes=()
first=true
while IFS= read -r line; do
    if [[ "${dupes[*]}" =~ "${line}" ]]; then
        continue
    else
        dupes+="$line"
        if $first; then
            echo $line > $new_file2 # later realised could've just done >filename to clear file; not changing this now
            first=false
        else
            echo $line >> $new_file2
        fi
    fi
done < $new_file

rm quotes.txt new.txt
mv new2.txt quotes.txt
