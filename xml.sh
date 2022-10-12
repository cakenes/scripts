#!/bin/bash

echo -e "Comparing against: $1\n" &> xmlout
argument=("$@")

for data in "${argument[@]}"
do
    if test "${data}" = "$1"; then
        continue
    fi
    echo "Xml to compare: ${data}" &>> xmlout
    echo "--------------------------------" &>> xmlout
    xmllint --noout --schema $1 ${data} &>> xmlout
    echo "" &>> xmlout
done

