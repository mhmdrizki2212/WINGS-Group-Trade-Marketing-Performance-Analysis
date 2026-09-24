--"Berapa revenue WINGS Group selama 2026?"

SELECT 
    SUM(fs.net_sales) AS total_revenue
FROM trade_marketing.fact_sales fs
JOIN trade_marketing.dim_date dd
ON fs.date_id = dd.date_id
WHERE dd.year = 2026;


-- "Berapa Total Banyaknya produk WINGS Group yang Terjual selama 2026?"
SELECT 
    SUM(fs.quantity) AS total_quantity
FROM trade_marketing.fact_sales fs
JOIN trade_marketing.dim_date dd
ON fs.date_id = dd.date_id
WHERE dd.year = 2026;


--"Berapa jumlah total transaksi WINGS Group selama tahun 2026?"
SELECT 
    COUNT(DISTINCT fs.transaction_id) AS total_transaction
FROM trade_marketing.fact_sales fs
JOIN trade_marketing.dim_date dd
ON fs.date_id = dd.date_id
WHERE dd.year = 2026;


--"Berapa total outlet WINGS Group yang aktif pada tahun 2026?"

SELECT 
    COUNT(DISTINCT fs.outlet_id) AS active_outlet
FROM trade_marketing.fact_sales fs
JOIN trade_marketing.dim_date dd
ON fs.date_id = dd.date_id
WHERE dd.year = 2026;


--"Bagaimana Revenue WINGS Group per-Bulan selama tahun 2026?"

SELECT
    dd.month,
    SUM(fs.net_sales) AS revenue
FROM trade_marketing.fact_sales fs
JOIN trade_marketing.dim_date dd
ON fs.date_id = dd.date_id
WHERE dd.year = 2026
GROUP BY dd.month
ORDER BY dd.month;



