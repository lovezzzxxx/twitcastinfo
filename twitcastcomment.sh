#!/bin/bash

if [[ ! -n "${1}" ]]; then
	echo "${0} 频道编号"
	echo "${0} \"kaguramea_vov/movie/593632557\""
	echo "${0} \"https://twitcasting.tv/kaguramea_vov/movie/593632557\""
	exit 1
fi



PART_URL=$(echo ${1} | sed 's/https:\/\/twitcasting.tv\///g' | sed 's/movie/moviecomment/g')
TOTAL_PAGE=$(curl -s "https://twitcasting.tv/${PART_URL}" | grep -o "${PART_URL}-[0-9]*" | tail -n 1 | grep -Eo "[0-9]*$")

PAGE=0
while [[ ! ${PAGE} -gt ${TOTAL_PAGE} ]]; do	
	PAGE_GET=$(curl -s "https://twitcasting.tv/${PART_URL}-${PAGE}")
	COM=$(echo $PAGE_GET | awk 'BEGIN{RS="<div class=\"tw-comment-history-item\" data-comment-id=\"";FS="\n";ORS="\n";OFS="\t"} $1 !~ /<!DOCTYPE HTML/ {COM_LINK_POS=match($1,"<a class=\"tw-comment-history-item__content__text\" href=\"[^\"]*\""); COM_LINK=substr($1,COM_LINK_POS+56,RLENGTH-57); COM_LINK_END_POS=COM_LINK_POS+RLENGTH+2; COM_DATE_POS=match($1,"datetime=\"[^\"]*\""); COM_DATE=substr($1,COM_DATE_POS+10,RLENGTH-11); USER_LINK_POS=match($1,"<a class=\"tw-comment-history-item__details__user-link\" href=\"[^\"]*\">"); USER_LINK=substr($1,USER_LINK_POS+61,RLENGTH-63); USER_LINK_END_POS=USER_LINK_POS+RLENGTH+1; USER_NAME_POS=match($1,"</a> </div> </div> </div> <time class=\"tw-comment-history-item__info__date\""); USER_NAME=substr($1,USER_LINK_END_POS,USER_NAME_POS-USER_LINK_END_POS-1); COM_END_POS=match($1,"</a> </div> <div class=\"tw-comment-history-item__info\">"); COM=substr($1,COM_LINK_END_POS,COM_END_POS-COM_LINK_END_POS-1); print COM_LINK "(" COM_DATE ")",USER_NAME "(" USER_LINK ")",COM}')
	[[ -n "${COM}" ]] || break
	echo "${COM}"
	PAGE=$(( ${PAGE} + 1 ))
done
