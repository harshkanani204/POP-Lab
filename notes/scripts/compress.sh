#!/bin/bash
#
# Script to compress the ogv file from recordmydesktop to .mp4 file
#

input=$1
output=`echo $1 | sed s/.ogv/.mp4/`
audiofilter="lowpass=3000,highpass=200"
# ffmpeg -i "$input"  -max_muxing_queue_size 1024 -ab 128k -ac 2 -vcodec libx265 -preset slow -crf 22 -threads 0 "$output"


# removed the -preset slow command.
ffmpeg -i "$input"  -max_muxing_queue_size 1024 -ab 128k -ac 2 -af "$audiofilter" -vcodec libx265 -crf 22 -threads 0 "$output"
