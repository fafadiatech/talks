import requests

URL = "https://vcet.edu.in/"
response = requests.get(URL)
print(response.status_code)
print(response.text)