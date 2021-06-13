# A simple script to screen for stocks that meet the Payback Time requirements.
#
# Creates four tables, one for all stocks ==10, <10. One for <8. Another for <6.

SELECT stocks.ticker, stocks.name, stocks.payback_time FROM isthisstockgood.stocks
WHERE stocks.payback_time  > 0 and stocks.payback_time <= 10
ORDER BY stocks.payback_time;