setup: 
	python3 -m venv venv
	
install: 
	source venv/bin/activate &&\
	pip install -r requirements.txt

test: 
	source venv/bin/activate &&\
	python -m pytest -vv --cov=. tests/*.py

lint:
    # only show warnings and errors for continuous delivery project
	source venv/bin/activate &&\
	pylint --disable=R,C web_service

clean:
	rm -rf venv

all: setup install lint test clean

save_requirements:
	pip freeze > requirements.txt