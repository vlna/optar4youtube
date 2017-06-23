[ "x$1" == "x" ] && { echo usage $0 YouTubevideoId ; echo e.g. $0 $ID ; exit 1 ; }

ID=$1

rm *.png ; rm *.pgm

youtube-dl -f 248/137 -o "%(id)s.%(ext)s" https://www.youtube.com/watch?v=$ID
[ $? -ne 0 ] && { echo Unable to download video ; exit 1 ; }

if [ -f $ID.webm ] ; then
    ffmpeg -ss 1.92 -i $ID.webm -vf "select=not(mod(n\,50)),transpose=1" -vsync vfr __%04d.png
else
    ffmpeg -ss 1.92 -i $ID.mp4 -vf "select=not(mod(n\,50)),transpose=1" -vsync vfr __%04d.png
fi

unoptar 0-22-38-24-6-1-2-24 _ | tar -x

rm __*.*
