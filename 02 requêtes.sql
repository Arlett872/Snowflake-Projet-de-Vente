-- Chiffre d’affaires total

SELECT
    SUM(quantity * unit_price) AS total_revenue
FROM sales;


-- CA par produit
SELECT
    product,
    SUM(quantity * unit_price) AS revenue
FROM sales
GROUP BY product
ORDER BY revenue DESC;

--CA par région et produit
SELECT
    region,
    product,
    SUM(quantity * unit_price) AS revenue
FROM sales
GROUP BY region, product;

--CA mensuel

SELECT
    TO_CHAR(sale_date, 'YYYY-MM') AS month,
    SUM(quantity * unit_price) AS revenue
FROM sales
GROUP BY month
ORDER BY month;


--Ranking des produits par CA

SELECT
    product,
    SUM(quantity * unit_price) AS revenue,
    RANK() OVER (ORDER BY SUM(quantity * unit_price) DESC) AS rank_product
FROM sales
GROUP BY product;

--Top produit par région
SELECT *
FROM (
    SELECT
        region,
        product,
        SUM(quantity * unit_price) AS revenue,
        RANK() OVER (
            PARTITION BY region
            ORDER BY SUM(quantity * unit_price) DESC
        ) AS rnk
    FROM sales
    GROUP BY region, product
)
WHERE rnk = 1;



