with sub as (
    select product_id,
    max(order_date) as max_dt
    from Orders
    group by 1
), ##Finds recent date
sub_res as (
    select o.product_id,order_id, order_date from Orders o, sub s where o.product_id = s.product_id and o.order_date = max_dt
) ##gets all orders for the product on that date
select product_name,o.product_id,order_id, order_date from Products p,sub_res o where o.product_id = p.product_id
order by product_name,product_id,order_id


"""
Table: Customers

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| customer_id   | int     |
| name          | varchar |
+---------------+---------+
customer_id is the column with unique values for this table.
This table contains information about the customers.
 

Table: Orders

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| order_id      | int     |
| order_date    | date    |
| customer_id   | int     |
| product_id    | int     |
+---------------+---------+
order_id is the column with unique values for this table.
This table contains information about the orders made by customer_id.
There will be no product ordered by the same user more than once in one day.
 

Table: Products

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| product_id    | int     |
| product_name  | varchar |
| price         | int     |
+---------------+---------+
product_id is the column with unique values for this table.
This table contains information about the Products.
 

Write a solution to find the most recent order(s) of each product.

Return the result table ordered by product_name in ascending order and in case of a tie by the product_id in ascending order. If there still a tie, order them by order_id in ascending order.


"""
