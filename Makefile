app_name ?= it-follows
app_title ?= "It Follows"
build_folder ?= webapp

i: install
install:
	brew install love luacheck

ci:
	sudo apt-get install -y love

run: ./it-follows/main.lua
	love ./it-follows

build: ./it-follows/
	rm -rf ${app_name}.love
	cd ./it-follows && zip -r ../${app_name}.love .

run-build: build
	love ./${app_name}.love

build-web: build
	rm -rf ${build_folder}
	npx -y love.js ${app_name}.love ${build_folder} -c -t ${app_title}

run-web: build-web
	npx -y http-server ${build_folder}

lint: .luacheckrc
	luacheck .
