#!/bin/bash

src_file="quotes.txt"
output_file="speech.txt"

>$output_file
while read -r line; do
    # read -ra split_string <<< "$line"

    # split_string=(${line//" ~"/ })
    # echo ${split_string[0]}
    # break

    author_name=""
    quote=""
    tilde=false

    # echo ${#line}
    for (( i=0; i<${#line}; i++ )); do
        char=${line:$i:1}

        if [[ $char == "~" ]]; then
            tilde=true
        fi

        if $tilde; then
            if [[ $char != "~" ]]; then
                author_name=$author_name$char
            fi
        else
            quote=$quote$char # need to fix the whitespace at the end of quote thing
        fi

    done

    echo "$author_name once said, \"$quote\"" >> $output_file
    # printf "\-\-\-\-\-\-\-\-\-\-\-\-\n"

    unset i # fuck this

done < $src_file
