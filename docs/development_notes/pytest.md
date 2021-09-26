## Pytest
### Troubleshooting
- functions should start with test to be found 
- need empty __init__.py in your package directories for it to find the directories properly (same for pylint)
- if pytest can't find modules for your code or installed libraries, you are probably using the globally installed pytest and not the one in your venv. verify this with: `which pytest`. 
- if it's the global one, you need to use these steps: 
  - create and activate your venv
  - install pytest in venv
  - deactivate
  - reactivate 
  - `which pytest` should now be using the virtualenv version 
  - per this [stackoverflow](https://stackoverflow.com/questions/35045038/how-do-i-use-pytest-with-virtualenv):
    - > The reason is that the path to pytest is set by the sourceing the activate file only after pytest is actually installed in the venv. You can't set the path to something before it is installed.Re-activateing is required for any console entry points installed within your virtual environment.
