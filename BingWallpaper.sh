#!/bin/sh
baseurl="www.bing.com"
imgurl=$(expr "$(curl -L $baseurl/?mkt=zh-CN | grep hprichbg)" : '.*g_img={url: "\(.*\)",id.*')
filename=$(expr "$imgurl" : '.*/\(.*\)')
localpath="/Users/$USER/Pictures/Bing/$(date "+%Y-%m-%d")-$filename"
curl -o $localpath  $baseurl/$imgurl
osascript -e "tell application \"Finder\" to set desktop picture to POSIX file \"$localpath\""
