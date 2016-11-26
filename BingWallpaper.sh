#!/bin/sh
baseUrl="cn.bing.com"
localDir="/Users/$USER/Pictures/BingWallpaper"
imgurl=$(expr "$(curl -L $baseUrl | grep hprichbg)" : '.*hprichbg\(.*\)",id.*')
filename=$(expr "$imgurl" : '.*/\(.*\)')
localpath="$localDir/$(date "+%Y-%m-%d")-$filename"
curl -o $localpath  $baseUrl/az/hprichbg/$imgurl
osascript -e "tell application \"Finder\" to set desktop picture to POSIX file \"$localpath\""
