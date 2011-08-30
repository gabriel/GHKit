
docs:
	VERSION=`cat XCConfig/Shared.xcconfig | grep "GHKIT_VERSION =" | cut -d '=' -f 2 | tr -d " "`
	rm -rf Documentation/html
	Documentation/appledoc/appledoc -t Documentation/appledoc/Templates -o Documentation/html -p GHKit -v $VERSION -c "GHKit" --company-id "me.rel" --warn-undocumented-object --warn-undocumented-member --warn-empty-description --warn-unknown-directive --warn-invalid-crossref --warn-missing-arg --no-repeat-first-par --keep-intermediate-files --create-html Classes/

gh-pages-deploy:
	rm -rf ../doctmp
	mkdir -p ../doctmp
	cp -R Documentation/html/html/* ../doctmp
	rm -rf Documentation/html/*
	git checkout gh-pages
	git symbolic-ref HEAD refs/heads/gh-pages
	rm .git/index
	git clean -fdx
	cp -R ../doctmp/* .
	git add .
	git commit -a -m 'Updating docs' && git push origin gh-pages
	git checkout master

gh-pages: docs gh-pages-deploy

