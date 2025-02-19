#!/bin/bash
set -e

TITLE=""
ARTIST=""
ALBUM=""
OUTPUT_DIR="$(pwd)"
echo "$OUTPUT_DIR"

while [[ $# -gt 0 ]]; do
  case $1 in
    -a|--artist)
      ARTIST="$2"
      shift # past argument
      shift # past value
      ;;
    -A|--album)
      ALBUM="$2"
      shift # past argument
      shift # past value
      ;;
    -t|--title)
      TITLE="$2"
      if [[ "$ALBUM" == "" ]]; then
        ALBUM="$TITLE"
      fi
      shift # past argument
      shift # past value
      ;;
    -d|--output-dir)
      OUTPUT_DIR="$2"
      shift # past argument
      shift # past value
      ;;
    --mkdirs)
      MKDIRS=YES
      shift # past argument
      ;;
    -*|--*)
      echo "Unknown option $1"
      exit 1
      ;;
    *)
      YOUTUBE_URL="$1"
      shift
      ;;
  esac
done


if ! command -v yt-dlp 2>&1 >/dev/null
then
    echo "yt-dlp could not be found"
    exit 1
fi


if ! command -v ffmpeg 2>&1 >/dev/null
then
    echo "ffmpeg could not be found"
    exit 1
fi

if [ "$TITLE" == "" ]; then
    TITLE="$(yt-dlp -o '%(title)s' --get-filename $YOUTUBE_URL)"
fi

echo "Artist: $ARTIST; Album: $ALBUM; Title: $TITLE"

m4a_title="$TITLE.m4a"
mp3_title="$TITLE.mp3"
echo "Will download $TITLE"
yt-dlp -f 140 -o "$m4a_title" --quiet $YOUTUBE_URL
echo "Download ended, convert to mp3 192k"
ffmpeg -i "$m4a_title" -c:a libmp3lame -b:a 192k -hide_banner -loglevel warning "$mp3_title"
rm "$m4a_title"

if ! command -v id3v2 2>&1 >/dev/null
then
    echo "Cannot write id3 tag, please install id3v2"
else
    id3v2 -t "$TITLE" -a "$ARTIST" -A "$ALBUM" "$mp3_title"
fi

if [ "$MKDIRS" == "YES" ]; then
    OUTPUT_DIR="$OUTPUT_DIR/$ARTIST/$ALBUM"
    mkdir -p "$OUTPUT_DIR"
fi

# move afterwards because yt-dlp has issues with NFS

if [ "$OUTPUT_DIR" != "$(pwd)" ]; then
    mv "$mp3_title" "$OUTPUT_DIR/$mp3_title"
fi

echo "Output to $OUTPUT_DIR/$mp3_title"
