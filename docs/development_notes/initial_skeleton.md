## Creating a new Project skeleton
1. create new GitHub repo (don't forget gitignore!)
2. clone locally 
3. activate virtual environment with venv
    ```bash
    python -m venv venv
    source venv/bin/activate
    ```
4. create a requirements.tt file and add pytest and pylint
5. install packages from requirements.txt: `pip install -r requirements.txt`
6. write a simple python function that you can test; I created a new file hello.py in web_service directory and wrote a very simple function 
7. write a python test: create a new test file in the tests directory. import the function you created and write a test function to verify the output
8. create a Makefile with setup, test, and lint commands
9. try them out, e.g. run `make test` and `make lint` from the command line


