## Setting up virtualenv for python development
You should use virtual environments to develop your python app so you aren't installing everything globally. Python has a `virtualenv` module for this.

The convention is to call the directory you create for it `env` though you could call it something else.

The hard way: Install and setup yourself: 
- You could install it globally `pip install virtualenv` and then in your project directory type `virtualenv env` to create a new virtual environment.
- Once it's created, run script to activate the virtual environment: 
  - First look at which python you are running by default: `which python`
    - The output might be something like `python: aliased to /usr/local/bin/python3` or `/Users/caseycolby/.pyenv/shims/python`
  - Then when you activate the virtual env: `source env/bin/activate`, `which python` should show the local env folder, e.g.: `/Users/caseycolby/git/msds/434-analytics-app-eng/finalproject/env/bin/python`
- Run `deactivate` to exit the virtualenv.

The Easy Way: Python actually comes installed with the venv module to manage all of this setup for you, but it's helpful to understand what it's for and what to do if it didn't. 
```bash
python -m venv venv
source venv/bin/activate
pip install Flask
pip freeze > requirements.txt
...
deactivate
```
