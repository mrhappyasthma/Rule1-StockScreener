# Display all stocks that meet the "big five" number requirements and are currently below MoS price.
SELECT big_five.name, big_five.margin_of_safety_price, big_five.current_price FROM (
  SELECT stocks.name, stocks.current_price, stocks.margin_of_safety_price FROM isthisstockgood.stocks
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
  AND (stocks.cash_max IS NOT NULL AND stocks.cash_max >= 10)
) AS big_five
WHERE big_five.current_price <= big_five.margin_of_safety_price;

