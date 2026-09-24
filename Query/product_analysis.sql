-- Which products and categories contribute the most to WINGS Group revenue in 2026?

-- SKU apa yang menghasilkan revenue terbesar selama 2026?
SELECT
    dp.sku_id,
    dp.product_name,
    SUM(fs.net_sales) AS revenue
FROM trade_marketing.fact_sales fs
JOIN trade_marketing.dim_date dd
    ON fs.date_id = dd.date_id
JOIN trade_marketing.dim_product dp
    ON fs.sku_id = dp.sku_id
WHERE dd.year = 2026
GROUP BY 
    dp.sku_id,
    dp.product_name
ORDER BY revenue DESC
LIMIT 10;


-- Kategori produk mana yang memberikan kontribusi revenue terbesar?
SELECT
    dp.category,
    SUM(fs.net_sales) AS revenue
FROM trade_marketing.fact_sales fs
JOIN trade_marketing.dim_date dd
    ON fs.date_id = dd.date_id
JOIN trade_marketing.dim_product dp
    ON fs.sku_id = dp.sku_id
WHERE dd.year = 2026
GROUP BY dp.category
ORDER BY revenue DESC;


--Brand mana yang menjadi kontributor revenue terbesar?
SELECT
    dp.brand,
    SUM(fs.net_sales) AS revenue
FROM trade_marketing.fact_sales fs
JOIN trade_marketing.dim_date dd
    ON fs.date_id = dd.date_id
JOIN trade_marketing.dim_product dp
    ON fs.sku_id = dp.sku_id
WHERE dd.year = 2026
GROUP BY dp.brand
ORDER BY revenue DESC;


--Berikan Ranking Product WINGS Group tahun 2026
SELECT
    dp.product_name,
    SUM(fs.net_sales) AS revenue,
    RANK() OVER(
        ORDER BY SUM(fs.net_sales) DESC
    ) AS product_rank
FROM trade_marketing.fact_sales fs
JOIN trade_marketing.dim_date dd
    ON fs.date_id = dd.date_id
JOIN trade_marketing.dim_product dp
    ON fs.sku_id = dp.sku_id
WHERE dd.year = 2026
GROUP BY dp.product_name;


