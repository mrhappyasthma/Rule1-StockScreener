# A simple script to screen for high ROIC stocks.

SELECT stocks.name FROM isthisstockgood.stocks
WHERE (stocks.roic_1 >= 10)
AND (stocks.roic_3 >= 10 OR stocks.roic_3 IS NULL)
AND (stocks.roic_5 >= 10 OR stocks.roic_5 IS NULL)
AND (stocks.roic_max >= 10 OR stocks.roic_max IS NULL);
