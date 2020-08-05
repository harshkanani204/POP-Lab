#!/bin/bash
#
# This scripts can be used to download the lectures. It uses the
# program youtube-dl
# <https://ytdl-org.github.io/youtube-dl/index.html> (package exists
# for Debian/Ubuntu)


urls=$(grep Video transcript.org | awk -F "::" '{ print $2 }')
mkdir -p youtube

for u in "$urls"
do
    youtube-dl -o 'youtube/%(title)s-%(alt-title)s.%(ext)s' "$u"
done
