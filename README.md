# Rule1-StockScreener
Scripts to populate a MySQL database with Rule #1 screened stocks.

## Stocklists

Any stock lists that you want to query should be CSV (comma-separated-value) files and should be placed in the `csv/` subdirectory.

For instance, this repository maintains a S&P 500 list in `csv/s&p.csv`.

## Dependencies

1. Install [python](https://www.python.org/downloads/) if it's not already on your system.
2. Install `pandas` via `python -m pip install pandas`.
3. Install [MySQL](https://dev.mysql.com/downloads/installer/)
4. Remember your `root` password set during the install as it will be needed by the script. The script assumes it's also `root`. If you set a separate password, then you'll need to update the code to use that password in the `connect` call.

## Populate the mySQL database

You will need to do this at least once, to initially populate the database. You may also want to run it periodically (monthly, once-per-quarter, annually, etc), depending on how fresh you want the data. (Most of the data does not change more than once per quarter or even annually, so it does not need to be refreshed too often.)

To populate the database, simply run `populate_database.py` optionally passing in a filename from the `csv/` subdirectory as the command line argument:

```
# If no filename is provided, defaults to `s&p.csv`
python3 populate_database.py
```

or

```
# Example providing a custom filename. This assumes you put `stocks.csv` in the `csv/` subdirectory.
python3 populate_database.py 'stocks.csv'
```

This script will connect to mySQL using `root`/`root` as the login. It will then create a new database called `isthisstockgood` with a table called `stocks` and populate it with the Rule #1 Investing computation data for the provided stocks.

(NOTE: If using `csv/s&p.csv` then this will take some time. There's 500 of them. You may also see some 'ERROR' messages from the underlying API, but this is working as intended. These are data errors in the underlying code which are being logged.)

## Exploring the table

The resulting table will look something like this:

![Screenshot of the mySQL database in a database viewer](https://i.imgur.com/XIt2ApD.png)

Helpful queries can be found in the `sql/` subdirectory.
