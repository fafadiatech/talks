from bs4 import BeautifulSoup
from regex_parser import extract_email

def is_name(some_text):
    candidates = ['Dr', 'Mr', 'Ms']
    for current in candidates:
        if some_text.find(current) != -1:
            return True
    return False

def extract_faculty(current):
    result = {}
    name = current.find('h2').text.strip()
    title = current.find('div', {'class': 'elementor-text-editor'})
    if not title:
        title = current.find("p")
    title = title.text.strip()
    email = "".join(extract_email(current.text))
    
    result['name'] = name
    result['title'] = title
    result['email'] = email
    return [result]

def extract_all(html):
    soup = BeautifulSoup(html, 'html.parser')
    results = []
    for current in soup.find_all('div', {'class': 'elementor-widget-wrap'}):
        name = current.find("h2")
        if name and is_name(name.text):
            results.extend(extract_faculty(current))
    return results