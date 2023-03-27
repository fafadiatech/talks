import re

def cleanup_email(email):
    if ">" in email and email.find(">") != -1:
        email = email[email.find(">") + 1:]
    email = email.strip()
    if ">" in email:
        email = email[email.find(">") + 1:]
    return email

def extract_email(html):
    results = []
    email_re = re.compile(r".+\@vcet\.edu\.in")
    for candidate in email_re.findall(html):
        results.append(cleanup_email(candidate))
    return results