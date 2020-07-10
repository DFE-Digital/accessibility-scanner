#!/bin/bash

mode=${1}
file=${2}

case ${mode} in
     sitemap) echo "Processing Sitemap" ;;
     file) echo "Processing File based" ;;
     *) echo "Unknown option"
        return 1 ;;
esac

CMD=$(find . -name a11y-crawl.rb)
ruby ${CMD} "--${mode}" "${file}" -U ${HTTP_USERNAME} -P ${HTTP_PASSWORD}
