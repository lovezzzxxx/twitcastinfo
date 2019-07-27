#!/bin/bash
PART_URL="${1}"

./twitcastinfo.sh "${PART_URL}" > "./twitcastinfo_${PART_URL/:/：}.log" ; 
mkdir "twitcastcomment_${PART_URL/:/：}"
for LINK in $(awk -F"[\t(]" '{print $1}' "./twitcastinfo_${PART_URL/:/：}.log"); do 
	NAME=$(echo ${LINK} | sed 's/\//_/g' | sed 's/:/：/g')
	./twitcastcomment.sh "${LINK}" > "./twitcastcomment_${PART_URL/:/：}/twitcastcomment${NAME}.log"; 
done
