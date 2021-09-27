"""
sample JSON rest API for GAE setup
"""
import flask

app = flask.Flask(__name__)

test_data = [{"greeting": "hello world"}]


@app.route('/', methods=['GET'])
def home():
    """
    sample Home endpoint for GAE setup
    """
    return '''<h1>Hello World App</h1>
<p>Hello! This is a sample rest JSON API. Go to /api/v1/greetings to test it out.</p>'''


@app.route('/api/v1/greetings', methods=['GET'])
def api_all():
    """
    sample JSON rest API endpoint for GAE setup
    """
    return flask.jsonify({"results": test_data})


# invoked only when running locally
# the flask local server will serve static files from the 'static' directory by default
# when hosted on GAE, confiure the entrypoint and static directory in app.yaml
if __name__ == '__main__':
    app.run(host='127.0.0.1', port=8080, debug=True)
