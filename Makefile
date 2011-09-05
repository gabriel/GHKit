
VERSION=$(shell cat XCConfig/Shared.xcconfig | grep "GHKIT_VERSION =" | cut -d '=' -f 2 | tr -d " ")

docs:
	rm -rf Documentation/output
	Documentation/appledoc/appledoc -t Documentation/appledoc/Templates -o Documentation/output -p GHKit -v $(VERSION) -c "GHKit" --company-id "me.rel" --warn-undocumented-object --warn-undocumented-member --warn-empty-description --warn-unknown-directive --warn-invalid-crossref --warn-missing-arg --no-repeat-first-par --keep-intermediate-files --docset-feed-url http://gabriel.github.com/gh-kit/publish/%DOCSETATOMFILENAME --docset-package-url http://gabriel.github.com/gh-kit/publish/%DOCSETPACKAGEFILENAME --publish-docset --index-desc Documentation/index.txt --create-html --create-docset Classes/ || echo ''

gh-pages: docs
	rm -rf ../doctmp
	mkdir -p ../doctmp
	cp -R Documentation/output/html/* ../doctmp
	cp -R Documentation/output/publish ../doctmp/publish
	rm -rf Documentation/output/*
	git checkout gh-pages
	git symbolic-ref HEAD refs/heads/gh-pages
	rm .git/index
	git clean -fdx
	cp -R ../doctmp/* .
	git add .
	git commit -a -m 'Updating docs' && git push origin gh-pages
	git checkout master
