#!/bin/bash

CMD=$(find . -name a11y-crawl.rb)
ruby ${CMD} ${*}  -U ${HTTP_USERNAME} -P ${HTTP_PASSWORD}
