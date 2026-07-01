SELECT COUNT(*)
FROM retail_project;


/* Total Revenue (Business KPI)*/
SELECT
    SUM(amount) AS total_revenue
FROM retail_project;


/* Revenue by Product Category*/
SELECT
    product_category,
    SUM(amount) AS total_sales
FROM retail_project
GROUP BY product_category
ORDER BY total_sales DESC;


/* Top 10 Customers by Spending*/
SELECT
    customer_id,
    "Name",
    SUM(amount) AS total_spent
FROM retail_project
GROUP BY customer_id, "Name"
ORDER BY total_spent DESC
LIMIT 10;


/* Sales by State*/
SELECT
    state,
    SUM(amount) AS total_sales
FROM retail_project
GROUP BY state
ORDER BY total_sales DESC;

/* Average Customer Rating by Product Category*/
SELECT
    product_category,
    ROUND(AVG(ratings)::NUMERIC, 2) AS average_rating
FROM retail_project
GROUP BY product_category
ORDER BY average_rating DESC;

/* 6. Payment Method Analysis*/
SELECT
    payment_method,
    COUNT(*) AS total_orders,
    SUM(amount) AS total_sales
FROM retail_project
GROUP BY payment_method
ORDER BY total_sales DESC;

/*Order Status Analysis*/
SELECT
    order_status,
    COUNT(*) AS total_orders
FROM retail_project
GROUP BY order_status;


/*Top 10 Selling Brands*/
SELECT
    product_brand,
    SUM(amount) AS total_sales
FROM retail_project
GROUP BY product_brand
ORDER BY total_sales DESC
LIMIT 10;


/*Customer Age Group Analysis*/

SELECT
CASE
    WHEN age < 20 THEN 'Below 20'
    WHEN age BETWEEN 20 AND 29 THEN '20-29'
    WHEN age BETWEEN 30 AND 39 THEN '30-39'
    WHEN age BETWEEN 40 AND 49 THEN '40-49'
    ELSE '50+'
END AS age_group,
COUNT(*) AS total_customers,
SUM(amount) AS total_sales
FROM retail_project
GROUP BY age_group
ORDER BY total_sales DESC;

/*Monthly Sales Trend*/

SELECT
    "Year",
    "Month",
    SUM(amount) AS monthly_sales
FROM retail_project
GROUP BY "Year", "Month"
ORDER BY "Year", "Month";


/*Top 5 Customers in Each State*/

SELECT *
FROM (
    SELECT
        state,
        customer_id,
        "Name",
        SUM(amount) AS total_sales,
        RANK() OVER (
            PARTITION BY state
            ORDER BY SUM(amount) DESC
        ) AS ranking
    FROM retail_project
    GROUP BY state, customer_id, "Name"
) ranked_customers
WHERE ranking <= 5;