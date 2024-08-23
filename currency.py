import requests

def get_currency_rate(currency):
    data = requests.get('https://www.cbr-xml-daily.ru/daily_json.js').json()
    return data['Valute'][currency]['Value']

