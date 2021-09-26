setup: 
	python3 -m venv venv &&\
	source venv/bin/activate
	
install: 
	pip install -r requirements.txt

test: 
	python -m pytest -vv --cov=. tests/*.py

lint:
    # only show warnings and errors for continuous delivery project
	pylint --disable=R,C web_service

clean:
	rm -rf .app

all: setup install lint test clean

save_requirements:
	pip freeze > requirements.txt
