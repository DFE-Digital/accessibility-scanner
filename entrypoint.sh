#!/bin/bash

mode=${1}
file=${2}

case ${mode} in
     sitemap) ;;
     file);;
     *) exit(1);;
esac

CMD=$(find . -name a11y-crawl.rb)
echo ruby ${CMD} "--${mode}" "${file}" -U ${HTTP_USERNAME} -P ${HTTP_PASSWORD}
