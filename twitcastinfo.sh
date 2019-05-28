#!/bin/bash
PART_URL="${1}"

PAGE=0
PAGE_LINK="show/0"
while true; do
	curl -s "https://twitcasting.tv/${PART_URL}/${PAGE_LINK}" | awk 'BEGIN{RS="<a class=\"tw-movie-thumbnail\"|<div class=\"paging\"";FS="\n";ORS="\n";OFS="\t"} $1 ~ /href/ {split($1,LINK,"\"") ; TITLE_POS=match($0,"<span class=\"tw-movie-thumbnail-title\">[^<]*</span>");TITLE=substr($0,TITLE_POS,RLENGTH);gsub("^<span class=\"tw-movie-thumbnail-title\">\n *| *</span>$","",TITLE) ; DATE_POS=match($0,"[0-9]*/[0-9]*/[0-9]* [0-9]*:[0-9]*:[0-9]*");DATE=substr($0,DATE_POS,19) ; if (match($0,"data-status=\"recorded\"")) print "RECORD",LINK[2],DATE,TITLE;else print "NO_REC",LINK[2],DATE,TITLE}'
	
	PAGE=$(( ${PAGE} + 1 ))
	PAGE_LINK=$(curl -s "https://twitcasting.tv/${PART_URL}/${PAGE_LINK}" | grep -o "show/${PAGE}-[0-9]*")
	
	[[ -n "${PAGE_LINK}" ]] || break
done
