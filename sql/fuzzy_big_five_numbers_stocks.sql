# A fuzzy query to screen for stocks that may meet the big 5 number requirements.
#
# For any field that exists, ensures the value is >= 5.
#
# This can be used as a screener to find stocks that you may want to investigate for your watch list.
#
# NOTE1: These stocks do NOT meet the Rule #1 requirements. It's much too lenient.
#
# NOTE2: This query does not take the current stock price into account.

SELECT stocks.ticker, stocks.name FROM isthisstockgood.stocks
WHERE (stocks.roic_1 >= 5 OR stocks.roic_1 IS NULL)
AND (stocks.roic_3 >= 5 OR stocks.roic_3 IS NULL)
AND (stocks.roic_5 >= 5 OR stocks.roic_5 IS NULL)
AND (stocks.roic_max >= 5 OR stocks.roic_max IS NULL)
AND (stocks.eps_1 >= 5 OR stocks.eps_1 IS NULL)
AND (stocks.eps_3 >= 5 OR stocks.eps_3 IS NULL)
AND (stocks.eps_5 >= 5 OR stocks.eps_5 IS NULL)
AND (stocks.eps_max >= 5 OR stocks.eps_max IS NULL)
AND (stocks.sales_1 >= 5 OR stocks.sales_1 IS NULL)
AND (stocks.sales_3 >= 5 OR stocks.sales_3 IS NULL)
AND (stocks.sales_5 >= 5 OR stocks.sales_5 IS NULL)
AND (stocks.sales_max >= 5 OR stocks.sales_max IS NULL)
AND (stocks.equity_1 >= 5 OR stocks.equity_1 IS NULL)
AND (stocks.equity_3 >= 5 OR stocks.equity_3 IS NULL)
AND (stocks.equity_5 >= 5 OR stocks.equity_5 IS NULL)
AND (stocks.equity_max >= 5 OR stocks.equity_max IS NULL)
AND (stocks.cash_1 >= 5 OR stocks.cash_1 IS NULL)
AND (stocks.cash_3 >= 5 OR stocks.cash_3 IS NULL)
AND (stocks.cash_5 >= 5 OR stocks.cash_5 IS NULL)
AND (stocks.cash_max >= 5 OR stocks.cash_max IS NULL);

