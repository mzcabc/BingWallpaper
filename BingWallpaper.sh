#!/bin/sh
localDir="/Users/$USER/Pictures/BingWallpaper"
filenameRegex=".*"$(date "+%Y-%m-%d")".*jpg"
log="$localDir/bin/log.log"

if [ ! -d "$localDir" ]; then
    mkdir "$localDir"
fi

findResult=$(find $localDir -regex $filenameRegex)

if [ ! -n "$findResult" ]; then
    baseUrl="cn.bing.com"
    imgurl=$(expr "$(curl -L $baseUrl | grep "&amp;rf")" : '.*href=\"\(\/th\?id=OHR\.[A-Za-z]*\_ZH\-CN[0-9]*\_1920x1080\.jpg\).*')
    echo $imgurl
    filename=$(expr "$imgurl" : '.*OHR\.\(.*\)')
    echo $filename
    localpath="$localDir/$(date "+%Y-%m-%d")-$filename"
    curl -o $localpath $baseUrl/$imgurl
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
