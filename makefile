test-chibi:
	chibi-scheme -m '(arvyy interface-test)' -e '(run-tests)'

test-gauche:
	gosh -I . -u 'arvyy.interface-test' -e '(begin (run-tests) (exit))' -b

build-doc:
	pandoc -f markdown -t html5 -o readme.html readme.md

package:
	snow-chibi package --version=1.0.0 --authors="Arvydas Silanskas" \
		--maintainers="Arvydas Silanskas <nma.arvydas.silanskas@gmail.com>" --doc=readme.html \
		--description="Interface abstraction for a set of functions" \
		--license="mit" \
		--test-library='(arvyy interface-test)' \
		arvyy/interface.sld
