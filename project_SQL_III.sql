use project_pizza;

-- Calculate the percentage contribution of each pizza type to total revenue.

WITH total_sales AS (
    SELECT SUM(order_details.quantity * pizzas.price) AS total_revenue
    FROM order_details
    JOIN pizzas ON pizzas.pizza_id = order_details.pizza_id
)
SELECT pizza_types.category, 
       ROUND((SUM(order_details.quantity * pizzas.price) / 
       total_sales.total_revenue) * 100, 2) AS revenue_percentage
FROM pizza_types
JOIN pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
JOIN order_details ON order_details.pizza_id = pizzas.pizza_id
CROSS JOIN total_sales 
GROUP BY pizza_types.category, total_sales.total_revenue
ORDER BY revenue_percentage DESC;

-- Analyze the cumulative revenue generated over time.

SELECT 
    order_date, 
    ROUND(SUM(revenue) OVER (ORDER BY order_date), 2) AS cumulative_revenue
FROM (
    SELECT 
        orders.order_date, 
        SUM(order_details.quantity * pizzas.price) AS revenue
    FROM order_details 
    JOIN pizzas ON order_details.pizza_id = pizzas.pizza_id
    JOIN orders ON orders.order_id = order_details.order_id
    GROUP BY orders.order_date
) AS sales;


-- Determine the top 3 most ordered pizza types based on revenue for each pizza category.

SELECT 
	name, category, revenue 
FROM (
    SELECT category, name, revenue, 
        RANK() OVER (PARTITION BY category ORDER BY revenue DESC) AS rankk
    FROM (
        SELECT pizza_types.category, pizza_types.name, 
            SUM(order_details.quantity * pizzas.price) AS revenue
        FROM pizza_types 
        JOIN pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN order_details ON order_details.pizza_id = pizzas.pizza_id
        GROUP BY pizza_types.category, pizza_types.name
    ) AS ranked_data
) AS filtered_data 
WHERE rankk <= 3;


