#!/bin/bash
vid="$@"

ffmpeg -i $vid -r 15 image%d.jpg

mkdir pgm

FILES="*.jpg"
for f in $FILES
do
	filename=$(basename $f)
	extension=${filename##*.}
	filename=${filename%.*}
	convert $f pgm/$filename.pgm
done
