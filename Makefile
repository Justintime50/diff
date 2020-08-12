VIRTUALENV := python3 -m venv

## help - Display help about make targets for this Makefile
help:
	@cat Makefile | grep '^## ' --color=never | cut -c4- | sed -e "`printf 's/ - /\t- /;'`" | column -s "`printf '\t'`" -t

## venv - Install the virtual environment
venv:
	$(VIRTUALENV) ~/.venv/diff-tool/
	ln -snf ~/.venv/diff-tool/ venv
	venv/bin/pip install -e ."[dev]"

## install - Install the project locally
install: | venv

## clean - Remove the virtual environment and clear out .pyc files
clean:
	rm -rf ~/.venv/diff-tool/ venv
	find . -name '*.pyc' -delete
	rm -rf dist
	rm -rf build
	rm -rf *.egg-info

## run - Run the project locally
run:
	venv/bin/python diff/diff_files.py

## lint - Lint the project
lint:
	venv/bin/flake8 diff/*.py

## test - Test the project
test:
	venv/bin/python -m unittest

.PHONY: help install clean lint test 