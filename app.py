from flask import Flask, render_template, request
from currency import get_currency_rate
from datetime import date
import os

app = Flask(__name__)
 
@app.route('/')
@app.route('/index')

def index():
   return render_template('index.html', today_day = date.today().strftime("%d.%m.%Y"))

@app.route('/rate')
def get_rate():
    currency = request.args.get('currency')
    if currency == "":
        currency = os.environ.get('CURR_DEFAULT','no')
        
    rate = get_currency_rate(currency)
    return render_template("rate.html", title = currency, rate = rate, today_day = date.today().strftime("%d.%m.%Y"))

if __name__ == '__main__':
    app.run(host="0.0.0.0", port=8000)