#!/bin/bash
set -e

TITLE=""
ARTIST=""
ALBUM=""
VALID=n
YEAR=


YT_MP3_ARGS=


while [[ $# -gt 0 ]]; do
  case $1 in
    -d|--output-dir)
      YT_MP3_ARGS="$YT_MP3_ARGS -d $2"
      shift # past argument
      shift # past value
      ;;
    --mkdirs)
      YT_MP3_ARGS="$YT_MP3_ARGS --mkdirs"
      shift # past argument
      ;;
    -*)
      echo "Unknown option $1"
      exit 1
      ;;
  esac
done

while [ "$VALID" != "y" ] && [ "$VALID" != "Y" ]; do
    echo "Enter artist ($ARTIST)"
    read R
    ARTIST=${R:-$ARTIST}

    echo "Enter title ($TITLE)"
    read R
    TITLE=${R:-$TITLE}

    echo "Enter album (empty to use same as title) ($TITLE)"
    read R
    ALBUM=${R:-$TITLE}
    echo "Enter year (empty will be ignored) ($year)"
    read YEAR

    echo "Enter Youtube URL ($URL)"
    read R
    URL=${R:-$URL}

    echo "Artist $ARTIST"
    echo "Alnum  $ALBUM"
    echo "Title  $TITLE"
    echo "YEAR   $YEAR"
    echo "URL    $URL"
    VALID=y
    echo "Is everything OK ? (Y/n)"
    read R
    VALID=${R:-$VALID}
done

if [ "$YEAR" != "" ]; then
    YT_MP3_ARGS="$YT_MP3_ARGS -y $YEAR"
fi

./yt_mp3.sh $YT_MP3_ARGS -a "$ARTIST" -A "$ALBUM" -t "$TITLE" "$URL"


