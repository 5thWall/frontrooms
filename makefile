SRC := $(filter-out $(wildcard macros/*.fnl), $(wildcard **/*.fnl))
IMG_SRC := $(wildcard assets/*.png)
OUT := $(patsubst %.fnl,build/%.lua,$(SRC))
IMG_OUT := $(patsubst %.png,build/%.png,$(IMG_SRC))
LIB_OUT := $(patsubst lib/%,%,$(wildcard lib/**/*.*))

build/%.lua: %.fnl;
	mkdir -p $(@D)
	bin/fennel --compile --correlate $< > $@
	
build/%.png: %.png;
	mkdir -p $(@D)
	cp $< $@
	
build: clean builddir copy-lib $(OUT) $(IMG_OUT)
	bin/fennel --compile --correlate main.fnl > build/main.lua
	bin/fennel --compile --correlate util.fnl > build/util.lua
	cp packager.yml build/packager.yml
	cd build; npx love-packager build love
	
builddir:
	mkdir build
	
copy-lib:
	cp -r lib build/lib

clean:
	rm -rf build