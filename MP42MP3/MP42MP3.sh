mkdir -p MP3 M4A

SAVEIFS=$IFS
IFS=$(echo -en "\n\b")

for i in `find . -type f -iname "*.mp4" -print`; do
echo $i
File_NAME=`echo $i | sed  -e 's/\.\///' -e  's/\.mp4//g' `
echo "Processing '$File_NAME'"

if [ ! -f M4A/${File_NAME}.m4a ]; then
    ffmpeg -i $i -vn -acodec copy  M4A/${File_NAME}.m4a
fi
if [ ! -f MP3/${File_NAME}.mp3 ]; then
    echo 'Convert to mp3'
    faad --stdio M4A/${File_NAME}.m4a | lame --preset standard - "MP3/${File_NAME}.mp3"
fi
done

IFS=$SAVEIFS
