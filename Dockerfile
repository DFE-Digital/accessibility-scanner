FROM node:latest

RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && echo "deb http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google.list && apt-get update && apt-get install -y google-chrome-stable && rm -rf /var/lib/apt/lists/*

RUN npm install -g pa11y pa11y-reporter-html pa11y-reporter-junit --unsafe-perm=true --allow-root

RUN apt-get update -y
RUN apt-get install ruby-full -y
RUN gem install bundler

WORKDIR /app
COPY pa11y.config.json /app/pa11y.config.json
COPY ruby/*  /app/
COPY entrypoint.sh  /app/
RUN bundle install

ENTRYPOINT ["/app/entrypoint.sh"]
