import psycopg2
import os

TABLE_NAME = 'rate_logs'


def get_db_connection():
    conn = psycopg2.connect(
        host=os.environ.get('DB_HOST'),
        port=os.environ.get('DB_PORT'),
        database=os.environ.get('DB_NAME'),
        user=os.environ.get('DB_USER'),
        password=os.environ.get('DB_PASSWORD'),
    )
    return conn


def create_table():
    conn = get_db_connection()
    cur = conn.cursor()
    cur.execute(f'''
    CREATE TABLE IF NOT EXISTS {TABLE_NAME} (
        currency text NULL,
        rate text NULL,
	    date_log timestamptz NULL,
	    ip_log text NULL);
    ''')
    conn.commit()
    cur.close()
    conn.close()


def get_rate_logs(currency):
    conn = get_db_connection()
    cur = conn.cursor()
    cur.execute(f'''
    SELECT currency, rate, date_log, ip_log FROM {TABLE_NAME} WHERE currency = '{currency}' order by date_log desc;
    ''')
    logs = cur.fetchall()
    cur.close()
    conn.close()
    return logs

def save_rate_log(currency, rate, date_log, ip_log):
    conn = get_db_connection()
    cur = conn.cursor()
    cur.execute(f'''
    INSERT INTO {TABLE_NAME} (currency, rate, date_log, ip_log)
    VALUES (%s, %s, %s, %s);
    ''', (currency, rate, date_log, ip_log))
    conn.commit()
    cur.close()
    conn.close()