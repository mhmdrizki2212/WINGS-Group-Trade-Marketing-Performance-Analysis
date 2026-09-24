--Channel mana yang menghasilkan revenue terbesar selama 2026?

SELECT
    do_.channel,
    SUM(fs.net_sales) AS revenue
FROM trade_marketing.fact_sales fs

JOIN trade_marketing.dim_date dd
    ON fs.date_id = dd.date_id

JOIN trade_marketing.dim_outlet do_
    ON fs.outlet_id = do_.outlet_id

WHERE dd.year = 2026

GROUP BY do_.channel

ORDER BY revenue DESC;


--Berapa persentase kontribusi setiap channel terhadap total revenue?

SELECT
    do_.channel,

    SUM(fs.net_sales) AS revenue,

    ROUND(
        SUM(fs.net_sales) * 100.0 /
        SUM(SUM(fs.net_sales)) OVER(),
        2
    ) AS contribution_percentage

FROM trade_marketing.fact_sales fs

JOIN trade_marketing.dim_date dd
    ON fs.date_id = dd.date_id

JOIN trade_marketing.dim_outlet do_
    ON fs.outlet_id = do_.outlet_id

WHERE dd.year = 2026

GROUP BY do_.channel

ORDER BY revenue DESC;


--Channel mana yang memiliki volume penjualan terbesar?

SELECT
    do_.channel,
    SUM(fs.quantity) AS total_quantity

FROM trade_marketing.fact_sales fs

JOIN trade_marketing.dim_date dd
    ON fs.date_id = dd.date_id

JOIN trade_marketing.dim_outlet do_
    ON fs.outlet_id = do_.outlet_id

WHERE dd.year = 2026

GROUP BY do_.channel

ORDER BY total_quantity DESC;


--Bagaimana performa outlet pada setiap channel?

SELECT
    do_.channel,
    COUNT(DISTINCT do_.outlet_id) AS total_outlet,
    SUM(fs.net_sales) AS revenue

FROM trade_marketing.fact_sales fs

JOIN trade_marketing.dim_date dd
    ON fs.date_id = dd.date_id

JOIN trade_marketing.dim_outlet do_
    ON fs.outlet_id = do_.outlet_id

WHERE dd.year = 2026

GROUP BY do_.channel

ORDER BY revenue DESC;
