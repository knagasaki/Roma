PREFIX=/usr
FILES=ChangeLog \
	g \
	index.html \
	Makefile \
	notam \
	parser \
	progressbar \
	release \
	ressource \
	roma \
	roma.css \
	roma.js \
	startroma.php \
	teilogo.jpg \
	VERSION 

.PHONY: release

default:
	@echo
	@echo TEI Roma
	@echo - install target puts files directly into ${PREFIX} 
	@echo - dist target  makes a release subdirectory of runtime files
	@echo There is no default action
	@echo

install: release
	mkdir -p ${PREFIX}/share/tei-roma
	(cd release; tar cf - . ) | (cd ${PREFIX}/share; tar xf - )
	mkdir -p ${PREFIX}/bin
	cp -p roma.sh ${PREFIX}/bin/roma
	chmod 755 ${PREFIX}/bin/roma

dist:  release
	(cd release; 	\
	ln -s tei-xsl tei-xsl-`cat ../VERSION` ; \
	zip -r tei-xsl-`cat ../VERSION`.zip tei-xsl-`cat ../VERSION` )

release: clean
	mkdir -p release/tei-roma
	tar --exclude=CVS -c -f - $(FILES) | (cd release/tei-roma; tar xf -)

clean:
	-rm -rf release
	-find . -name "*~" | xargs rm
	-find . -name semantic.cache | xargs rm

