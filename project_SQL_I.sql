use project_pizza;

-- Retrieve the total number of orders placed
 select count(order_id) as total_orders from orders;
 
 -- Calculate the total revenue generated from pizza sales.
 select round(sum(order_details.quantity * pizzas.price),2) as total_revenue
 From order_details join pizzas 
 on pizzas.pizza_id = order_details.pizza_id;
 
 -- Identify the highest-priced pizza.
 select pizza_types.name, pizzas.price
 From pizza_types join pizzas
 on pizza_types.pizza_type_id = pizzas.pizza_type_id
 order by pizzas.price desc limit 1;
 
 -- Identify the most common pizza size ordered.
 SELECT pizzas.size, COUNT(order_details.order_details_id) AS order_count
FROM pizzas  
JOIN order_details ON pizzas.pizza_id = order_details.pizza_id  
GROUP BY pizzas.size  
ORDER BY order_count DESC limit 1;

-- List the top 5 most ordered pizza types along with their quantities.
SELECT pizza_types.name, sum(order_details.quantity) as quantity
FROM pizza_types
JOIN pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
JOIN order_details 
ON order_details.pizza_id = pizzas.pizza_id
Group by pizza_types.name order by quantity desc limit 5;

 
