FROM node:14.5.0-stretch

# hadolint ignore=DL4006
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - 
RUN echo "deb http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google.list 

# hadolint ignore=DL3009
RUN apt-get update -y
RUN apt-get install -y google-chrome-stable=83.0.4103.116-1  --no-install-recommends
RUN apt-get install ruby-full=1:2.3.3 -y --no-install-recommends
RUN rm -rf /var/lib/apt/lists/*

RUN npm install -g pa11y@5.3.0 pa11y-reporter-html@2.0.0 pa11y-reporter-junit@1.1.0 --unsafe-perm=true --allow-root

RUN gem install bundler:1.17.2

WORKDIR /app
COPY pa11y.config.json /app/pa11y.config.json
COPY ruby/*  /app/
COPY entrypoint.sh  /app/
RUN bundle install

ENTRYPOINT ["/app/entrypoint.sh"]
