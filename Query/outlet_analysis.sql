--Outlet mana yang menghasilkan revenue terbesar pada tahun 2026?
SELECT
    do_.outlet_id,
    do_.outlet_name,
    do_.channel,
    do_.region,
    SUM(fs.net_sales) AS revenue

FROM trade_marketing.fact_sales fs

JOIN trade_marketing.dim_date dd
    ON fs.date_id = dd.date_id

JOIN trade_marketing.dim_outlet do_
    ON fs.outlet_id = do_.outlet_id

WHERE dd.year = 2026

GROUP BY
    do_.outlet_id,
    do_.outlet_name,
    do_.channel,
    do_.region

ORDER BY revenue DESC

LIMIT 10;


--Berapa kontribusi masing-masing outlet terhadap total revenue?

SELECT
    do_.outlet_name,
    
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

GROUP BY
    do_.outlet_name

ORDER BY revenue DESC;


--Bagaimana distribusi revenue berdasarkan outlet?

SELECT
    do_.region,
    SUM(fs.net_sales) AS revenue,
    COUNT(DISTINCT do_.outlet_id) AS total_outlet

FROM trade_marketing.fact_sales fs

JOIN trade_marketing.dim_date dd
    ON fs.date_id = dd.date_id

JOIN trade_marketing.dim_outlet do_
    ON fs.outlet_id = do_.outlet_id

WHERE dd.year = 2026

GROUP BY do_.region

ORDER BY revenue DESC;


-- Revenue by Outlet Tier 2026

SELECT
    do_.tier,
    COUNT(DISTINCT do_.outlet_id) AS total_outlet,
    SUM(fs.net_sales) AS revenue

FROM trade_marketing.fact_sales fs

JOIN trade_marketing.dim_date dd
    ON fs.date_id = dd.date_id

JOIN trade_marketing.dim_outlet do_
    ON fs.outlet_id = do_.outlet_id

WHERE dd.year = 2026

GROUP BY do_.tier

ORDER BY revenue DESC;


-- Outlet Revenue Ranking

SELECT

    do_.outlet_id,
    do_.outlet_name,
    do_.channel,

    SUM(fs.net_sales) AS revenue,

    RANK() OVER(
        ORDER BY SUM(fs.net_sales) DESC
    ) AS outlet_rank

FROM trade_marketing.fact_sales fs

JOIN trade_marketing.dim_date dd
    ON fs.date_id = dd.date_id

JOIN trade_marketing.dim_outlet do_
    ON fs.outlet_id = do_.outlet_id

WHERE dd.year = 2026

GROUP BY
    do_.outlet_id,
    do_.outlet_name,
    do_.channel

ORDER BY outlet_rank;
