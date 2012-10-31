.PHONY: docs build test coverage build_rpm

ifndef VTENV_OPTS
VTENV_OPTS = "--no-site-packages"
endif

build:	
	virtualenv $(VTENV_OPTS) .
	bin/python setup.py develop

test:	bin/nosetests
	bin/nosetests -x vaurien

coverage: bin/coverage
	bin/nosetests --with-coverage --cover-html --cover-html-dir=html --cover-package=vaurien

docs: bin/sphinx-build
	SPHINXBUILD=../bin/sphinx-build $(MAKE) -C docs html $^

bin/sphinx-build: bin/python
	bin/pip install sphinx
	bin/pip install coverage

bin/nosetests: bin/python
	bin/pip install nose

bin/coverage: bin/python
	bin/pip install coverage
