#!/bin/bash
PART_URL="${1}"

PAGE=0
PAGE_LINK="show/0"
while true; do
	INFO_NOTIME=$(curl -s "https://twitcasting.tv/${PART_URL}/${PAGE_LINK}" | awk 'BEGIN{RS="<a class=\"tw-movie-thumbnail\"|<div class=\"paging\"";FS="\n";ORS="\n";OFS="\t"} $1 ~ /href/ {split($1,LINK,"\"") ; TIME_POS=match($0,"<span class=\"tw-movie-thumbnail-duration\">[^<]*");TIME=substr($0,TIME_POS+42,RLENGTH-42) ; TITLE_POS=match($0,"<span class=\"tw-movie-thumbnail-title\">[^<]*</span>");TITLE=substr($0,TITLE_POS,RLENGTH);gsub("^<span class=\"tw-movie-thumbnail-title\">\n *| *</span>$","",TITLE) ; LABEL_POS=match($0,"<span class=\"tw-movie-thumbnail-label\">[^<]*");LABEL=substr($0,LABEL_POS+39,RLENGTH-39) ; DATE_POS=match($0,"[0-9]*/[0-9]*/[0-9]* [0-9]*:[0-9]*:[0-9]*");DATE=substr($0,DATE_POS,19) ; DATE_POS=match($0,"[0-9]*/[0-9]*/[0-9]* [0-9]*:[0-9]*:[0-9]*");DATE=substr($0,DATE_POS,19) ; VIEW_POS=match($0,"<span class=\"tw-movie-thumbnail-view\">[^<]*");VIEW=substr($0,VIEW_POS+38,RLENGTH-38);sub(",","",VIEW) ; COM_POS=match($0,"<span class=\"tw-movie-thumbnail-comment\">[^<]*");COM=substr($0,COM_POS+41,RLENGTH-41);sub(",","",COM) ; if (match($0,"data-status=\"recorded\"")) print LINK[2]"("DATE")","RECORD("TIME")",TITLE"("LABEL")",VIEW"("COM")";else print LINK[2]"("DATE")","NO_REC("TIME")",TITLE"("LABEL")",VIEW"("COM")"}')
	
	LINE=0
	while true; do
		LINE=$(( ${LINE} + 1 ))
		INFO=$(echo "${INFO_NOTIME}" | sed -n "${LINE}p")
		[[ ! -n "${INFO}" ]] && break
		
		if [[ $(echo "${INFO}" | awk -F"\t" '{print $2}') == "NO_REC()" ]]; then
			LINK="https://twitcasting.tv/$(echo "${INFO}" | awk -F"[(\t]" '{print $1}')"
			TIME=$(curl -s ${LINK} | awk '{TIME_POS=match($0,"<span class=\"tw-player-meta__status_item\">Duration:[^<]*</span>");TIME=substr($0,TIME_POS+52,RLENGTH-60) ; if(TIME!="") print TIME}')
			echo "${INFO}" | sed "s/\tNO_REC()\t/\tNO_REC(${TIME})\t/g"
		else
			echo "${INFO}"
		fi
	done
		
	PAGE=$(( ${PAGE} + 1 ))
	PAGE_LINK=$(curl -s "https://twitcasting.tv/${PART_URL}/${PAGE_LINK}" | grep -o "show/${PAGE}-[0-9]*")
	
	[[ -n "${PAGE_LINK}" ]] || break
done
