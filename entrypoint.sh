#!/bin/bash

while getopts m:f: o
do	case "$o" in
	m)	mode="$OPTARG" ;;
	f)	file="$OPTARG" ;;
	[?])	exit 1;;
	esac
done

ruby a11y-crawl.rb "--"${mode} ${file} -U ${HTTP_USERNAME} -P ${HTTP_PASSWORD}
