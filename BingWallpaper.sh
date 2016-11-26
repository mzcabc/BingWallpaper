#!/bin/sh
localDir="/Users/$USER/Pictures/BingWallpaper"
filenameRegex=".*"$(date "+%Y-%m-%d")".*jpg"
log=$localDir/log.log

findResult=$(find $localDir -regex $filenameRegex)
if [ ! -n "$findResult" ]; then
    baseUrl="cn.bing.com"
    imgurl=$(expr "$(curl -L $baseUrl | grep hprichbg)" : '.*hprichbg\(.*\)",id.*')
    filename=$(expr "$imgurl" : '.*/\(.*\)')
    localpath="$localDir/$(date "+%Y-%m-%d")-$filename"
    curl -o $localpath $baseUrl/az/hprichbg/$imgurl
    osascript -e "tell application \"Finder\" to set desktop picture to POSIX file \"$localpath\""
    echo "$(date +"%Y-%m-%d %H:%M:%S") Downloaded $filename" >> log
else
    echo "$(date +"%Y-%m-%d %H:%M:%S") Exist" >> log
    exit 0
fi
