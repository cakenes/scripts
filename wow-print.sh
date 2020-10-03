#!/bin/bash

id=$(wmctrl -l | grep "World of Warcraft" | awk '{print $1}')
color=$(grabc -w $id -l +429+1022)
echo ${color:1:2}
