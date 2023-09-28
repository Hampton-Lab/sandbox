#!/bin/bash
fileid="1gv8ndlHwRC2GFm8jjnA5CIerI5DyLXBV"
filename="./data/Iceland.csv"
curl -c ./cookie -s -L "https://drive.google.com/uc?export=download&id=${fileid}" > /dev/null
curl -Lb ./cookie "https://drive.google.com/uc?export=download&confirm=`awk '/download/ {print $NF}' ./cookie`&id=${fileid}" -o ${filename}