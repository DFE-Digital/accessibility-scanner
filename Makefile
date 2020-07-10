build:
	docker build . -t dfedigital/accessibility_crawler:latest

test-sitemap:
	docker run -it  -e HTTP_USERNAME -e HTTP_PASSWORD accessibility_crawler -m sitemap  -f "https://www.bbc.co.uk/news/localnews/locations/sitemap.xml"

test-files:
	docker run -it  -v $(PWD):/apt/test -e HTTP_USERNAME -e HTTP_PASSWORD accessibility_crawler -m file -f /apt/test/test.file

test-sitemap-beta:
	docker run -it  -e HTTP_USERNAME -e HTTP_PASSWORD accessibility_crawler -m sitemap  -f "https://beta-adviser-getintoteaching.education.gov.uk/sitemap.xml"
