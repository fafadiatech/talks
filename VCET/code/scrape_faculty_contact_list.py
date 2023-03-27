import re
import requests
from regex_parser import extract_email
from bs4_parser import extract_all as extract_all_bs4

frontier = [
"https://vcet.edu.in/computer-engineering/",
"https://vcet.edu.in/computer-science-and-engineering-data-science/",
"https://vcet.edu.in/information-technology/",
"https://vcet.edu.in/artificial-intelligence-and-data-science/",
"https://vcet.edu.in/mechanical-engineering/",
"https://vcet.edu.in/electronics-and-telecommunication-engineering/",
"https://vcet.edu.in/civil-engineering-2/",
"https://vcet.edu.in/instrumentation-engineering/",
]

def download_page(url):
    headers={'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/102.0.0.0 Safari/537.36'}
    response = requests.get(url, headers=headers)
    return response.status_code, response.text

results = []

while len(frontier) > 1:
    url = frontier.pop()
    status_code, html = download_page(url)
    # print(extract_email(html))
    results.extend(extract_all_bs4(html))
    print(status_code, url)

with open("final.tsv", "w") as output:
    processed = {}
    for current in results:
        if current['email'] in processed:
            continue
        row = "\t".join(current.values()) + "\n"
        output.write(row)
        processed[current['email']] = True