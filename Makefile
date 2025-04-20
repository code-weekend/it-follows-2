app_name ?= it-follows

i: install
install:
	brew install love luacheck

run: ./it-follows/main.lua
	love ./it-follows

build: ./it-follows/
	cd ./it-follows && zip -9 -r ${app_name}.love .

run-build: build
	love ./it-follows/${app_name}.love

lint: .luacheckrc
	luacheck .
