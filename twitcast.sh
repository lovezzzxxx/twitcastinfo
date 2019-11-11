#!/bin/bash

if [[ ! -n "${1}" ]]; then
	echo "${0} 频道编号 获取此时间之后的评论"
	exit 1
fi



PART_URL="${1}"
DATE_AFTER="${2}" ; [[ "${DATE_AFTER}" == "" ]] || DATE_AFTER_TIMESTAMP=$(date -d "${DATE_AFTER}" +%s)



./twitcastinfo.sh "${PART_URL}" > "./twitcastinfo_${PART_URL/:/：}.log" ; 
mkdir "twitcastcomment_${PART_URL/:/：}"
awk -F"\t" '{print $1}' "./twitcastinfo_${PART_URL/:/：}.log" | while read LINE; do
	LINK=$(echo ${LINE} | awk -F"[()]" '{print $1}') ; NAME=$(echo ${LINK} | sed 's/\//_/g' | sed 's/:/：/g')
	DATE=$(echo ${LINE} | awk -F"[()]" '{print $2}') ; DATE_TIMESTAMP=$(date -d "${DATE}" +%s)
	if [[ "${DATE_AFTER}" == "" ]] || [[ "${DATE_TIMESTAMP}" -gt "${DATE_AFTER_TIMESTAMP}" ]]; then
		./twitcastcomment.sh "${LINK}" > "./twitcastcomment_${PART_URL/:/：}/twitcastcomment${NAME}.log"
	fi
done
