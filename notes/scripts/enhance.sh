#!/bin/bash
#
# usage: enhance.sh input 20dBq
#
# increase the volume and remove noise.
#

input=$1
amount="lowpass=3000,highpass=200"
output=`echo $1 | sed s/.mp4/-enhanced.mp4/`

ffmpeg -i $1 -vcodec copy -af "$amount" $output
