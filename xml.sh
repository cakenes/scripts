#!/bin/bash

argument=("$@")

for data in "${argument[@]}"
do
    if test "${data}" = "$1"; then
        continue
    fi
    echo "Comparing: ${data} vs. $1" &>> xmlout
    echo "--------------------------------" &>> xmlout
    xmllint --noout --schema $1 ${data} &>> xmlout
    echo -e "\n" &>> xmlout
done

