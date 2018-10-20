DC_RUN ?= docker-compose run --rm --user $$(id -u):$$(id -g)
PYTHON_DC_PREFIX ?= ${DC_RUN} --entrypoint python
PIPENV_DC_PREFIX ?= ${DC_RUN} --entrypoint pipenv -e TERM=xterm-256color  -e PIPENV_DONT_LOAD_ENV=1  -e PIPENV_CACHE_DIR=/jupyter-notebook/pipenv/.pipenv-cache -e PIPENV_SHELL=/bin/bash

.PHONY: install
install:
	${PIPENV_DC_PREFIX} jupyter \
		install

.PHONY: start-notebook
start-notebook:
	${PIPENV_DC_PREFIX} --service-ports jupyter \
		run python -m jupyter notebook --ip 0.0.0.0 --no-browser
