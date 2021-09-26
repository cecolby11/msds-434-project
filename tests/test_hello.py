from web_service import hello

def test_func():
    result = hello.myfunc()
    assert result == 1
