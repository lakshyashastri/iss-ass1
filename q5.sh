#!/bin/bash

# take input
read -r string

# define funcs
chr() {
  [ "$1" -lt 256 ] || return 1
  printf "\\$(printf '%03o' "$1")"
}

ord() {
  LC_CTYPE=C printf '%d' "'$1"
}

### reverse string
echo $string | rev

### print next char
new_str=""
for (( i==0; i<${#string}; i++ )); do
    char=${string:$i:1}
    # ascii_val=`echo $char | tr -d "\n" | od -An -t dC`
    if [[ $char == " " ]]; then
        ascii_val=32
    else
        ascii_val=`ord $char`
    fi

    let new_val=$ascii_val+1
    new_char=`chr $new_val`
    new_str=$new_str$new_char
    # awk '{printf("%c",$next_val)}'
done

echo $new_str

### print half in reverse
let len=${#string}/2
let full_len=${#string}

half_revved_str=""
for (( i=$len-1; i>=0; i-- )); do
    char=${string:$i:1}
    half_revved_str=$half_revved_str$char
done

second_half=""
for (( i=$len; i<$full_len; i++ )); do
    char=${string:$i:1}
    second_half=$second_half$char
done

echo $half_revved_str$second_half
