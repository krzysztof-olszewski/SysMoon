# Project configuration
LUA_ROCKS_TREE := .rock
LUA := lua
LUAROCKS := luarocks
BUSTED := busted

# Load LuaRocks paths into environment
ROCKS_ENV := eval "$$($(LUAROCKS) path --tree=$(LUA_ROCKS_TREE))"

.PHONY: help init install test clean

help:
	@echo "Available commands:"
	@echo "  make init     - Initialize LuaRocks and create rockspec"
	@echo "  make install  - Install dependencies into $(LUA_ROCKS_TREE)"
	@echo "  make test     - Run tests with Busted inside .rock environment"
	@echo "  make clean    - Remove local rock tree"

init:
	$(LUAROCKS) init

install:
	$(LUAROCKS) install --tree=$(LUA_ROCKS_TREE) busted

test:
	@echo "Running tests with Busted..."
	@$(ROCKS_ENV); $(BUSTED)

clean:
	rm -rf $(LUA_ROCKS_TREE)

setup: init install
	@echo "Project setup complete!"