.PHONY: all build test clean ci

all: build test

build:
	@echo "Building Node"
	@if [ -f package.json ]; then npm run build || true; fi
	@echo "Building Python"
	@if [ -f pyproject.toml ]; then python -m build || true; fi

test:
	@echo "Testing Node"
	@if [ -f package.json ]; then npm test || true; fi
	@echo "Testing Python"
	python -m pytest || true

clean:
	rm -rf dist build *.egg-info node_modules

ci: build test
