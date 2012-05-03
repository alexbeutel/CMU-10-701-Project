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
	#convert $f -background "#000000" -alpha "Background" -rotate "90>" .temp/image$num.jpg
	#convert $f -background "#FFFFFF" -alpha "Background" -rotate "90>" .temp/image$num.jpg
	convert $f -background "#FFFFFF" -alpha "Background" .temp/image$num.jpg
	num=$(($num + $one))
done
ffmpeg -f image2 -r 15 -i .temp/image%d.jpg  video.mp4

rm -rf .temp/
