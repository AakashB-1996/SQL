# Write your MySQL query statement below
with recent_3_orders as (
    select customer_id,
    order_id,
    order_date,
    rank() over(partition by customer_id order by order_date desc) as rnk
    from Orders
)
select c.name as customer_name,r.customer_id,r.order_id,r.order_date from Customers c, recent_3_orders r
where r.customer_id = c.customer_id and r.rnk <= 3
order by customer_name,customer_id,order_date desc

"""
Table: Customers

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| customer_id   | int     |
| name          | varchar |
+---------------+---------+
customer_id is the column with unique values for this table.
This table contains information about customers.
 

Table: Orders

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| order_id      | int     |
| order_date    | date    |
| customer_id   | int     |
| cost          | int     |
+---------------+---------+
order_id is the column with unique values for this table.
This table contains information about the orders made by customer_id.
Each customer has one order per day.
 

Write a solution to find the most recent three orders of each user. If a user ordered less than three orders, return all of their orders.

Return the result table ordered by customer_name in ascending order and in case of a tie by the customer_id in ascending order. If there is still a tie, order them by order_date in descending order.
"""
