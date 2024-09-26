#!/bin/bash
set -e
file_title="$(yt-dlp -o '%(title)s' --get-filename $1)"
m4a_title="$file_title.m4a"
mp3_title="$file_title.mp3"
echo "Will download $file_title"
yt-dlp -f 140 -o "$m4a_title" $1
echo "Download ended, convert to mp3 192k"
ffmpeg -i "$m4a_title" -c:a libmp3lame -b:a 192k  "$mp3_title"
rm "$m4a_title"
echo "$mp3_title"
