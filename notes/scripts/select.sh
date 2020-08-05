#!/usr/bin/env bash

input=$1
output=$(echo $1 | sed s/.mp4/-cut.mp4/)
start=$2
end=$3
ffmpeg  -i "$input" -ss "$start" -t "$end" -async 1  "$output"
