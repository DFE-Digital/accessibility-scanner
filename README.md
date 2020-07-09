# Accessibility Crawler
Accessibility crawler is a Ruby application which raps the [Pa11y](https://pa11y.org/) accessibility scanner. Enabling multi-site scanning from a docker container.

## Requirements
If you want to run without Docker then the  [Pa11y](https://pa11y.org/) application needs to be installed in accordance with [GitHub Pa11y](https://github.com/pa11y/pa11y)

## Usage
### Sitemap
Sitemap mode enables the scanner to read a simple sitemap and parse through the listed URLs 

       ruby axe-crawler.rb --sitemap  "https://www.bbc.co.uk/news/localnews/locations/sitemap.xml"

### File Mode
When no site map is available the scanner can be used to process a list of URLS from a file.

    ruby axe-crawler.rb --file  /apt/test/test.file

### Authentication
In either mode if the site requires authentication, then the Username and Password can be entered using the -P and -U options.

    ruby axe-crawl.rb --sitemap  "https://www.bbc.co.uk/news/localnews/locations/sitemap.xml" -U ${HTTP_USERNAME} -P ${HTTP_PASSWORD}

### Options

    --help     , -h Help Page
    --sitemap  , -s Site Map Mode
    --file     , -f File Mode
    --username , -U HTTP Authentication User
    --password , -P HTTP Authentication Password 
    --verbose  , -v Verbose Logging
## Docker
### Repository

    [Docker](https://hub.docker.com/repository/docker/dfedigital/accessibility_crawler) holds versions of the image

### Build

    make build

### Execute
To execute with docker the parameters are passed in, the username and password can be passed in as environment variables

    HTTP_USERNAME
    HTTP_PASSWORD

To run with file mode the directory with the test file needs to be mounted as a volume:

    docker run -it  -v $(PWD):/apt/test -e HTTP_USERNAME -e HTTP_PASSWORD accessibility_crawler:latest --file  /apt/test/test.file

To run in sitemap mode is simply:

    docker run -it accessibility_crawler:latest --sitemap  "https://www.bbc.co.uk/news/localnews/locations/sitemap.xml"

