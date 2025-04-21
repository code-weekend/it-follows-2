app_name ?= it-follows
app_title ?= It Follows

i: install
install:
	brew install love luacheck

ci:
	sudo apt-get install -y love luacheck

run: ./it-follows/main.lua
	love ./it-follows

build: ./it-follows/
	cd ./it-follows && zip -9 -r ${app_name}.love .

run-build: build
	love ./it-follows/${app_name}.love

build-web: build
	npx -y love.js it-follows/${app_name}.love webapp/ -c -t ${app_title}

run-web: build-web
	npx -y http-server ./webapp/

lint: .luacheckrc
	luacheck .
