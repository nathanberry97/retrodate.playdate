.PHONY: clean
.PHONY: all
.PHONY: run

SIM="Playdate Simulator"

all: src
	mkdir -p build
	pdc src build/retrodate.pdx

clean:
	rm -rf build/retrodate.pdx

run: all
	$(PLAYDATE_SDK_PATH)/bin/$(SIM).app/Contents/MacOS/$(SIM) build/retrodate.pdx
