SASS := sass
OPEN := open
ROOT_PATH := /Users/cmingxu/Library/Application\ Support/SketchUp\ 2015/SketchUp/Plugins
SU_APP := /Applications/SketchUp\ 2015/SketchUp.app
POCH_SECONDS = $(shell date +%s)
SU_ID="$(shell ps aux | grep 'SketchUp.app' | grep -v 'grep' | tr -s ' ' | cut -d' ' -f2)"


default: all

all: build_css linking kill_su start_su

linking:
	rm $(ROOT_PATH)/su_building.rb
	ln -s src/su_building/su_building.rb $(ROOT_PATH)/su_building.rb
	rm -r $(ROOT_PATH)/su_building
	ln -s src/su_building/su_building $(ROOT_PATH)/su_building

goto:
	cd $(ROOT_PATH)

kill_su:
	kill -9 $(SU_ID)

start_su:
	$(OPEN) $(SU_APP)

build_css:
	$(SASS) src/su_building/stylesheets/style.css.sass src/su_building/stylesheets/style.css

preview:
	$(OPEN) src/su_building/html/index.html

#production
package:

gp:
	git add .
	message=$(read -p "message: ")
	git ci -m "[MOD] $(message)"
	git push origin master

