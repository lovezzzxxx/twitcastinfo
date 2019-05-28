#!/bin/bash
PART_URL="${1}"

PAGE=0
PAGE_LINK="show/0"
while true; do
	echo ${PAGE_LINK}

	curl -s "https://twitcasting.tv/${PART_URL}/${PAGE_LINK}" | awk 'BEGIN{RS="<a class=\"tw-movie-thumbnail\"|<div class=\"paging\"";FS="[\n<>]";ORS="\n";OFS="\t"} $1 ~ /href/ {if (NF<100) {split($1,LINK,"\"");TITLE=$18;gsub("^ *| *$","",TITLE);DATE=$30;print "NO RECORD",LINK[2],DATE,TITLE} ; if (NF>100) {split($1,LINK,"\"");TITLE=$30;gsub("^ *| *$","",TITLE);DATE=$42;print "RECORD",LINK[2],DATE,TITLE}}'
	
	PAGE=$(( ${PAGE} + 1 ))
	PAGE_LINK=$(curl -s "https://twitcasting.tv/${PART_URL}/${PAGE_LINK}" | grep -o "show/${PAGE}-[0-9]*")
	
	[[ -n "${PAGE_LINK}" ]] || break
done
