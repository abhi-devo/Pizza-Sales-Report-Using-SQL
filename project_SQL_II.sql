use project_pizza;

-- Join the necessary tables to find the total quantity of each pizza category ordered.

SELECT pizza_types.category, SUM(order_details.quantity) AS quantity
FROM pizza_types
JOIN pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
JOIN order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.category
ORDER BY quantity DESC;


-- Determine the distribution of orders by hour of the day. 

select hour(order_time) as hour_time , count(order_id) as order_count 
from orders
group by hour_time;


-- Join relevant tables to find the category-wise distribution of pizzas.
select category, count(name) from pizza_types
group by category;


-- Group the orders by date and calculate the average number of pizzas ordered per day.

select avg(quantity) as average_pizza_ordered from
(select orders.order_date, sum(order_details.quantity) as quantity
from orders join order_details
on orders.order_id = order_details.order_id
group by orders.order_date) as orders_by_date;

-- Determine the top 3 most ordered pizza types based on revenue.

SELECT pizza_types.name, 
       SUM(order_details.quantity * pizzas.price) AS revenue
FROM pizza_types
JOIN pizzas ON pizzas.pizza_type_id = pizza_types.pizza_type_id
JOIN order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.name  
ORDER BY revenue DESC limit 3;  


