setup: 
	python3 -m venv venv
	
install: 
	. venv/bin/activate &&\
	pip install -r requirements.txt

test: 
	. venv/bin/activate &&\
	python -m pytest -vv --cov=. tests/*.py

lint:
    # only show warnings and errors for continuous delivery project
	. venv/bin/activate &&\
	pylint --disable=R,C web_service

clean:
	rm -rf venv

all: setup install lint test clean

save_requirements:
	pip freeze > requirements.txt
