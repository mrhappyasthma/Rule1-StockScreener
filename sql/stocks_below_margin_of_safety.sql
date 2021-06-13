# A simple script to display all stocks whose current price is lower than the margin of safety price.
#
# NOTE: This script does not check that these stocks meet all of the Rule #1 criteria. It's just a
#        simple screener.

SELECT stocks.ticker, stocks.name, stocks.margin_of_safety_price, stocks.current_price FROM isthisstockgood.stocks
WHERE stocks.current_price <= stocks.margin_of_safety_price;