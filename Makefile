i: install
install:
	brew install love luacheck

run: ./it-follows/main.lua
	love ./it-follows

lint: .luacheckrc
	luacheck .
