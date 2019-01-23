#!/bin/sh
localDir="/Users/$USER/Pictures/BingWallpaper"
filenameRegex=".*"$(date "+%Y-%m-%d")".*jpg"
log="$localDir/bin/log.log"

findResult=$(find $localDir -regex $filenameRegex)
if [ ! -n "$findResult" ]; then
    baseUrl="cn.bing.com"
    imgurl=$(expr "$(curl -L $baseUrl | grep "href=\"\/az\/hprichbg\/rb")" : '.*hprichbg.rb.\(.*jpg\)\"')
    filename=$(expr "$imgurl" : '.*/\(.*\)')
    localpath="$localDir/$(date "+%Y-%m-%d")-$imgurl"
    curl -o $localpath $baseUrl/az/hprichbg/rb/$imgurl
    osascript -e "                              \
        tell application \"System Events\" to   \
            tell every desktop to               \
                set picture to \"$localpath\""
    osascript -e "display notification \"$filename Downloaded\" with title \"BingWallpaper\""
    echo "$(date +"%Y-%m-%d %H:%M:%S") Downloaded $filename" >> $log
else
    echo "$(date +"%Y-%m-%d %H:%M:%S") Exist" >> $log
    exit 0
fi
