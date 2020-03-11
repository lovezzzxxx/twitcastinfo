#!/bin/bash

if [[ ! -n "${1}" ]]; then
	echo "${0} 频道编号 获取此时间之后的评论"
	echo "${0} \"kaguramea_vov\" 2001/01/01 01:01:01"
	echo "${0} \"https://twitcasting.tv/kaguramea_vov\" 2001/01/01 01:01:01"
	exit 1
fi



PART_URL=$(echo ${1} | sed 's/https:\/\/twitcasting.tv\///g')
DATE_AFTER="${2}" ; [[ "${DATE_AFTER}" == "" ]] || DATE_AFTER_TIMESTAMP=$(date -d "${DATE_AFTER}" +%s)

./twitcastuser.sh "${PART_URL}" > "./twitcastuser_${PART_URL/:/：}.log" ; 
mkdir "twitcastcomment_${PART_URL/:/：}"
awk -F"\t" '{print $1}' "./twitcastuser_${PART_URL/:/：}.log" | while read LINE; do
	LINK=$(echo ${LINE} | awk -F"[()]" '{print $1}') ; NAME=$(echo ${LINK} | sed 's/\//_/g' | sed 's/:/：/g')
	DATE=$(echo ${LINE} | awk -F"[()]" '{print $2}') ; DATE_TIMESTAMP=$(date -d "${DATE}" +%s)
	if [[ "${DATE_AFTER}" == "" ]] || [[ "${DATE_TIMESTAMP}" -gt "${DATE_AFTER_TIMESTAMP}" ]]; then
		./twitcastcomment.sh "${LINK}" > "./twitcastcomment_${PART_URL/:/：}/twitcastcomment${NAME}.log"
	fi
done
