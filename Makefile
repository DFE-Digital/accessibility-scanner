build:
	docker build . -t accessibility_crawler:latest 

test-sitemap:
	docker run -it  -e HTTP_USERNAME -e HTTP_PASSWORD accessibility_crawler --sitemap  https://www.bbc.co.uk/news/localnews/locations/sitemap.xml 

test-files:
	docker run -it  -v $(PWD):/apt/test -e HTTP_USERNAME -e HTTP_PASSWORD accessibility_crawler --file  /apt/test/test.file

