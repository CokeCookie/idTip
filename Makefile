zip:
	$(eval VER := $(shell grep Version idTip.toc 2>/dev/null | cut -c 13-))
	rm -rf zip/idTip
	mkdir -p zip/idTip
	cp idTip.lua idTip.toc README.md zip/idTip
	cd zip && zip idTip-$(VER)-retail.zip idTip/*
	
	rm -rf zip/idTip
	mkdir -p zip/idTip
	perl -p -i -e 's|Interface: [0-9]+|Interface: 11305|g' idTip.toc
	cp idTip.lua idTip.toc README.md zip/idTip
	cd zip && zip idTip-$(VER)-classic.zip idTip/*
	
	rm -rf zip/idTip
	mkdir -p zip/idTip
	perl -p -i -e 's|Interface: [0-9]+|Interface: 20501|g' idTip.toc
	cp idTip.lua idTip.toc README.md zip/idTip
	cd zip && zip idTip-$(VER)-tbcc.zip idTip/*
	
	perl -p -i -e 's|Interface: [0-9]+|Interface: 90001|g' idTip.toc
	rm -rf zip/idTip

patch:
	$(eval VER := $(shell grep Version idTip.toc 2>/dev/null | cut -c 13-))
	yarn -s run versions -b $(VER) -P patch idTip.toc
	$(MAKE) zip

minor:
	$(eval VER := $(shell grep Version idTip.toc 2>/dev/null | cut -c 13-))
	yarn -s run versions -b $(VER) -P minor idTip.toc
	$(MAKE) zip

major:
	$(eval VER := $(shell grep Version idTip.toc 2>/dev/null | cut -c 13-))
	yarn -s run versions -b $(VER) -P major idTip.toc
	$(MAKE) zip

.PHONY: zip patch minor major

