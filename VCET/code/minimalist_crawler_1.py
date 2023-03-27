import requests

URL = "https://vcet.edu.in/"
headers={'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/102.0.0.0 Safari/537.36'}
response = requests.get(URL, headers=headers)
print(response.status_code)
print(response.text)