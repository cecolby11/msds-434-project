import json

def handler(request):
  request = request.get_data()
  try: 
      request_json = json.loads(request.decode())
  except ValueError as e:
      print(f"Error decoding JSON: {e}")
      return "JSON Error", 400
  name = request_json.get("name") or "World"
  msg = f'Hello, {name}!'
  print(msg)
  return msg
