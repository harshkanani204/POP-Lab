#!/bin/bash
input=$1
output=`echo $1 | sed s/.txt/.mp4/`

ffmpeg -f concat -safe 0  -i "$input"  -c copy "$output"
