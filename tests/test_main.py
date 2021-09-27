import main

def test_home_page():
    response = main.home()
    assert 'Hello' in response

# @TODO: test the API routes/responses not just unit testing the function 
