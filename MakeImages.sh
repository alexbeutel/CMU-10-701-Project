#!/bin/bash
vid="$@"

ffmpeg -r 15 -i $vid image%d.jpg

mkdir pgm

FILES="*.jpg"
for f in $FILES
do
	filename=$(basename $f)
	extension=${filename##*.}
	filename=${filename%.*}
	convert $f pgm/$filename.pgm
done
