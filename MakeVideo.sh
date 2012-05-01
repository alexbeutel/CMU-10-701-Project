#FILES="$@"
mkdir .temp

num=0
one=1

FILES="*.png"
for f in $FILES
do
	filename=$(basename $f)
	extension=${filename##*.}
	filename=${filename%.*}
	#ps2pdf $f $filename.pdf
	convert $f -background "#000000" -alpha "Background" -rotate "90>" .temp/image$num.jpg
	num=$(($num + $one))
done
ffmpeg -f image2 -i .temp/image%d.jpg -r 15 video.mp4

#rm mod-*.jpg
rm -rf .temp/
