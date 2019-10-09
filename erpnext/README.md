# Alexa, talk to ERPNext!

## Motivation

Voice assistants are becoming integral part of business workflows. In this talk we will explore how Alexa and ERPNext can be integrated with each other. Key components required for doing this includes:

1. Voice Assistant: Alexa
1. Glue: AWS Lambda
1. Custom ERPNext API: Built using Custom App

## Why integrated voice with ERPNext?

1. Quick query {for High level management}
2. Natural Response {vs Review of multiple reports}
3. Implement domain concepts {e.g. Red flags for inventory}

Some of the queries that get frequently asked include:

1. Sales: What is sales during X? {Daily, Weekly, Monthly, Quarterly}
1. Inventory: What are some red flags?
1. CRM: How many leads did we generate in last X period? {Daily, Weekly, Monthly, Quarterly}

We will approach implementing this from bottom up i.e. from Custom ERPNext API to ERPNext

## API Layer in ERPNext

Create custom app named `alex_integration` using following

```sh
cd /home/frappe/frappe-bench
bench new-app alexa_integration
cd apps/alexa_integration/alexa_integration
touch api.py
```

Next we will create a white-listed API as follows

```python
import frappe

def sales_for(period):
    from datetime import datetime, timedelta

    if period == "daily":
        start = str(datetime.now().date() - timedelta(days=1))
    elif period == "weekly":
        start = str(datetime.now().date() - timedelta(days=7))
    elif period == "monthly":
        start = str(datetime.now().date() - timedelta(days=30))
    else:
        start = str(datetime.now().date() - timedelta(days=90))

    totals = list(frappe.db.get_values("Sales Order", filters={
        "status": ("in", ["Completed", "To Deliver and Bill", "To Bill", "Closed"]),
        "transaction_date": ['>=', start],
        }, fieldname=["Total"]))
    return sum([item[0] for item in totals])

@frappe.whitelist(allow_guest=True)
def sales(period):
    return sales_for(period)
```

**Note:** Don't forget decorator `@` <- I've wasted 2 hours for this silly mistake

Install the app using

```sh
bench --site <what_ever_site> install-app alexa_integration
```

Test your API endpoint using

```
curl -d “usr=SuperAdministrator&pwd=SuperSecurePasswd” http://localhost:<port_no>/api/method/alexa_integration.api.sales?period=weekly
```

## Future Scope

1. Security
1. Better NLP
    1. Entity Detection
    1. Intent Classification
    1. Handling disambiguation
1. Better API Wrapper