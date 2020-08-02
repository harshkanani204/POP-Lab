#!/bin/bash
input=$1
output=`echo $1 | sed s/.ogv/.mp4/`

# ffmpeg -i "$input"  -max_muxing_queue_size 1024 -ab 128k -ac 2 -vcodec libx265 -preset slow -crf 22 -threads 0 "$output"


# removed the -preset slow command.
ffmpeg -i "$input"  -max_muxing_queue_size 1024 -ab 128k -ac 2 -vcodec libx265 -crf 22 -threads 0 "$output"
