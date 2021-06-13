# A simple query to return stocks that meet all the big 5 number requirements,
# including having a long enough track record of data.
#
# This can be used as a screener to find stocks for you watch list.
#
# NOTE: This query does not take the current stock price into account.
SELECT stocks.ticker, stocks.current_price, stocks.margin_of_safety_price FROM isthisstockgood.stocks
WHERE (stocks.roic_1 IS NOT NULL AND stocks.roic_1 >= 10)
AND (stocks.roic_3 IS NOT NULL AND stocks.roic_3 >= 10)
AND (stocks.roic_5 IS NOT NULL AND stocks.roic_5 >= 10)
AND (stocks.roic_max IS NOT NULL AND stocks.roic_max >= 10)
AND (stocks.eps_1 IS NOT NULL AND stocks.eps_1 >= 10)
AND (stocks.eps_3 IS NOT NULL AND stocks.eps_3 >= 10)
AND (stocks.eps_5 IS NOT NULL AND stocks.eps_5 >= 10)
AND (stocks.eps_max IS NOT NULL AND stocks.eps_max >= 10)
AND (stocks.sales_1 IS NOT NULL AND stocks.sales_1 >= 10)
AND (stocks.sales_3 IS NOT NULL AND stocks.sales_3 >= 10)
AND (stocks.sales_5 IS NOT NULL AND stocks.sales_5 >= 10)
AND (stocks.sales_max IS NOT NULL AND stocks.sales_max >= 10)
AND (stocks.equity_1 IS NOT NULL AND stocks.equity_1 >= 10)
AND (stocks.equity_3 IS NOT NULL AND stocks.equity_3 >= 10)
AND (stocks.equity_5 IS NOT NULL AND stocks.equity_5 >= 10)
AND (stocks.equity_max IS NOT NULL AND stocks.equity_max >= 10)
AND (stocks.cash_1 IS NOT NULL AND stocks.cash_1 >= 10)
AND (stocks.cash_3 IS NOT NULL AND stocks.cash_3 >= 10)
AND (stocks.cash_5 IS NOT NULL AND stocks.cash_5 >= 10)
AND (stocks.cash_max IS NOT NULL AND stocks.cash_max >= 10);

