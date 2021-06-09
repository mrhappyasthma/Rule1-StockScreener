from csv import reader
import mysql.connector as sql
import os
import pandas as pd
import sys

sys.path.append(os.path.join(os.path.dirname(os.path.realpath(__file__)), 'IsThisStockGood'))
from IsThisStockGood.src.DataFetcher import fetchDataForTickerSymbol

# Connect to mysql using the default root login.
mydb = sql.connect(
  host="localhost",
  user="root",
  password="root",
)

# Select the 'isthisstockgood' database or create it if it does not yet exist.
mycursor = mydb.cursor(buffered=True)
mycursor.execute("SHOW DATABASES")
database_name = 'isthisstockgood'
database_exists = False
for db in mycursor:
  if db[0] == database_name:
    database_exists = True
    break

if not database_exists:
  mycursor.execute("CREATE DATABASE " + database_name)
mycursor.execute("USE " + database_name)

# Create the stocks table
table_name = 'stocks'
mycursor.execute("DROP TABLE IF EXISTS " + table_name)
mycursor.execute("CREATE TABLE " + table_name + " (name VARCHAR(255) PRIMARY KEY, roic FLOAT, eps FLOAT, sales FLOAT, equity FLOAT, cash FLOAT, long_term_debt BIGINT, free_cash_flow BIGINT, debt_payoff_time FLOAT, debt_equity_ratio FLOAT, ttm_net_income BIGINT, margin_of_safety_price FLOAT, sticker_price FLOAT, current_price FLOAT)")

# Iterate all the S&P stocks and insert them into the database.
with open('csvs/s&p.csv', 'r') as stock_list:
  csv_reader = reader(stock_list)
  for row in csv_reader:
    ticker = row[0]
    #data = fetchDataForTickerSymbol(ticker)
    mycursor.execute("INSERT INTO stocks (name) VALUES ('" + ticker + "')")
mydb.commit()

print("Record Inserted")