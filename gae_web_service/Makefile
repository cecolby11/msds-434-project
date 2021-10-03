setup: 
	python3 -m venv venv

install_dev: 
	. venv/bin/activate &&\
	pip install -r requirements_dev.txt

install: 
	. venv/bin/activate &&\
	pip install -r requirements.txt

test: 
	. venv/bin/activate &&\
	pytest -vv --cov=. tests/*.py

lint:
    # only show warnings and errors for continuous delivery project
	. venv/bin/activate &&\
	pylint --disable=R,C ./main.py

clean:
	rm -rf venv

all: setup install lint test clean

save_requirements:
	pip freeze > requirements.txt
