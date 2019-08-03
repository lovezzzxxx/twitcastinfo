#!/bin/bash
PART_URL=$(echo ${1} | sed 's/https:\/\/twitcasting.tv\///g' | sed 's/movie/moviecomment/g')
TOTAL_PAGE=$(curl -s "https://twitcasting.tv/${PART_URL}" | grep -o "${PART_URL}-[0-9]*" | tail -n 1 | grep -Eo "[0-9]*$")

PAGE=0
while [[ ! ${PAGE} -gt ${TOTAL_PAGE} ]]; do	
	COM=$(curl -s "https://twitcasting.tv/${PART_URL}-${PAGE}" | awk 'BEGIN{RS="<td class=\"comment\">";FS="\n";ORS="\n";OFS="\t"} $1 ~ /<span class=\"user\">/ {USER_NAME_POS=match($1,"[^<>]*</a><span class=\"name\">");USER_NAME=substr($1,USER_NAME_POS,RLENGTH-23); USER_LINK_POS=match($1,"</a><span class=\"name\">[^<>]*");USER_LINK=substr($1,USER_LINK_POS+23,RLENGTH-23) ; COM_LINK_POS=match($1,"</span><br><p><a href=\"[^\"]*\">");COM_LINK=substr($1,COM_LINK_POS+23,RLENGTH-25) ; COM_START_POS=COM_LINK_POS+RLENGTH ; COM_END_POS=match($1,"</a></p><br>");COM=substr($1,COM_START_POS,COM_END_POS-COM_START_POS) ; COM_DATE_POS=match($2,"Date.parse[(]\"[^\"]*");COM_DATE=substr($2,COM_DATE_POS+12,RLENGTH-12) ; print COM_LINK "(" COM_DATE ")",USER_NAME USER_LINK,COM}')
	[[ -n "${COM}" ]] || break
	echo "${COM}"
	PAGE=$(( ${PAGE} + 1 ))
done
