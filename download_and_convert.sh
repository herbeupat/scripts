yt-dlp -a list.txt -f 140 -o "%(title)s.%(ext)s"
for f in *.m4a; do ffmpeg -n -i "$f" -codec:a libmp3lame -qscale:a 2  "mp3s/${f%.*}.mp3"; done
