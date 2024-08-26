from flask import Flask, render_template, request
from currency import get_currency_rate
from datetime import date, timezone, datetime
from db import create_table, get_rate_logs, save_rate_log
import os
import socket

app = Flask(__name__)
 
@app.route('/')
@app.route('/index')

def index():
   create_table()
   return render_template('index.html', today_day = date.today().strftime("%d.%m.%Y"))

@app.route('/rate', methods=['post', 'get'])
def get_rate():
    currency = request.args.get('currency')
    if currency == "":
        currency = os.environ.get('CURR_DEFAULT','no')

    rate = get_currency_rate(currency)

    today_day = date.today().strftime("%d.%m.%Y")
    IPAddr = socket.gethostbyname(socket.gethostname())
    dt = datetime.now(timezone.utc)

    save_rate_log(currency, rate, dt, IPAddr)
    
    logs = get_rate_logs(currency)

    return render_template("rate.html", currency = currency, rate = rate, today_day = today_day, logs = logs)

if __name__ == '__main__':
    #os.makedirs('/rates',exist_ok=True)
    app.run(host="0.0.0.0", port=5000)