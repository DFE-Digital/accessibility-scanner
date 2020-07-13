#!/bin/bash

CMD=$(find . -name a11y-crawl.rb)
ruby ${CMD} ${*} 
