from csv import reader
import mysql.connector as sql
import os
import pandas as pd
import sys

sys.path.append(os.path.join(os.path.dirname(os.path.realpath(__file__)), 'IsThisStockGood'))
from IsThisStockGood.src.DataFetcher import fetchDataForTickerSymbol


def setValueForFieldWithName(mycursor, table_name, ticker, field, value):
  mycursor.execute("UPDATE " + table_name + " SET " + field + "=" + str(value) + " WHERE name = '" + ticker + "'")


def setValuesForFieldRangeWithName(mycursor, table_name, ticker, field, values):
  if not values or not len(values):
    return
  suffixes = ['1', '3', '5', 'max']
  for i in range(len(values)):
    setValueForFieldWithName(mycursor, table_name, ticker, field + '_' + suffixes[i], values[i] if values[i] else "NULL")

def insertDataIntoTableForTicker(mycursor, table_name, ticker):
  data = fetchDataForTickerSymbol(ticker)
  if not data:
    print("Error fetching data for ticker: " + ticker)
    return
  mycursor.execute("INSERT INTO " + table_name + " (name) VALUES ('" + ticker + "')")
  setValuesForFieldRangeWithName(mycursor, table_name, ticker, 'roic', data.get('roic', []))
  setValuesForFieldRangeWithName(mycursor, table_name, ticker, 'eps', data.get('eps', []))
  setValuesForFieldRangeWithName(mycursor, table_name, ticker, 'sales', data.get('sales', []))
  setValuesForFieldRangeWithName(mycursor, table_name, ticker, 'equity', data.get('equity', []))
  setValuesForFieldRangeWithName(mycursor, table_name, ticker, 'cash', data.get('cash', []))
  setValueForFieldWithName(mycursor, table_name, ticker, 'long_term_debt', data.get('long_term_debt', "NULL"))
  setValueForFieldWithName(mycursor, table_name, ticker, 'free_cash_flow', data.get('free_cash_flow', "NULL"))
  setValueForFieldWithName(mycursor, table_name, ticker, 'debt_payoff_time', data.get('debt_payoff_time', "NULL"))
  setValueForFieldWithName(mycursor, table_name, ticker, 'debt_equity_ratio', data.get('debt_equity_ratio', "NULL"))
  setValueForFieldWithName(mycursor, table_name, ticker, 'ttm_net_income', data.get('ttm_net_income', "NULL"))
  setValueForFieldWithName(mycursor, table_name, ticker, 'margin_of_safety_price', data.get('margin_of_safety_price', "NULL"))
  setValueForFieldWithName(mycursor, table_name, ticker, 'sticker_price', data.get('sticker_price', "NULL"))
  setValueForFieldWithName(mycursor, table_name, ticker, 'current_price', data.get('current_price', "NULL"))


def connectToMySQLUsingRootLogin():
  """Connect to mysql using the default root login."""
  mydb = sql.connect(
    host="localhost",
    user="root",
    password="root",
  )
  return mydb


def selectOrCreateDatabase(mycursor, database_name):
  """Select the 'isthisstockgood' database or create it if it does not yet exist."""
  mycursor.execute("SHOW DATABASES")
  database_exists = False
  for db in mycursor:
    if db[0] == database_name:
      database_exists = True
      break

  if not database_exists:
    mycursor.execute("CREATE DATABASE " + database_name)
  mycursor.execute("USE " + database_name)


def createTable(table_name):
  """Create the stocks table"""
  mycursor.execute("DROP TABLE IF EXISTS " + table_name)
  mycursor.execute("CREATE TABLE " + table_name + " (name VARCHAR(255) PRIMARY KEY, "
                                                  "roic_1 FLOAT, "
                                                  "roic_3 FLOAT, "
                                                  "roic_5 FLOAT, "
                                                  "roic_max FLOAT, "
                                                  "eps_1 FLOAT, "
                                                  "eps_3 FLOAT, "
                                                  "eps_5 FLOAT, "
                                                  "eps_max FLOAT, "
                                                  "sales_1 FLOAT, "
                                                  "sales_3 FLOAT, "
                                                  "sales_5 FLOAT, "
                                                  "sales_max FLOAT, "
                                                  "equity_1 FLOAT, "
                                                  "equity_3 FLOAT, "
                                                  "equity_5 FLOAT, "
                                                  "equity_max FLOAT, "
                                                  "cash_1 FLOAT, "
                                                  "cash_3 FLOAT, "
                                                  "cash_5 FLOAT, "
                                                  "cash_max FLOAT, "
                                                  "long_term_debt BIGINT, "
                                                  "free_cash_flow BIGINT, "
                                                  "debt_payoff_time FLOAT, "
                                                  "debt_equity_ratio FLOAT, "
                                                  "ttm_net_income BIGINT, "
                                                  "margin_of_safety_price FLOAT, "
                                                  "sticker_price FLOAT, "
                                                  "current_price FLOAT)")


def addStocksToTableFromCSVFile(table_name, csv_filename):
  """Iterate all the S&P stocks and insert them into the database."""
  with open(csv_filename, 'r') as stock_list:
    csv_reader = reader(stock_list)
    for row in csv_reader:
      insertDataIntoTableForTicker(mycursor, table_name, row[0])
      mydb.commit()


if __name__ == "__main__":
  print("Connecting to database...")
  mydb = connectToMySQLUsingRootLogin()
  mycursor = mydb.cursor(buffered=True)
  selectOrCreateDatabase(mycursor, 'isthisstockgood')
  print("Creating table...")
  table_name = 'stocks'
  createTable(table_name)
  print("Adding stocks...")
  filename = sys.argv[1] if len(sys.argv) == 2 else 's&p.csv'
  addStocksToTableFromCSVFile(table_name, 'csv/' + filename)
  print("Records inserted!")