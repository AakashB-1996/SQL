# Write your MySQL query statement below
with max_trans as(
    select 
    transaction_id,
    dense_rank() over(partition by date(day) order by amount desc) as rnk
    from Transactions
)
select transaction_id from max_trans where rnk = 1 order by transaction_id

"""
Table: Transactions

+----------------+----------+
| Column Name    | Type     |
+----------------+----------+
| transaction_id | int      |
| day            | datetime |
| amount         | int      |
+----------------+----------+
transaction_id is the column with unique values for this table.
Each row contains information about one transaction.
 

Write a solution to report the IDs of the transactions with the maximum amount on their respective day. If in one day there are multiple such transactions, return all of them.

Return the result table ordered by transaction_id in ascending order.

The result format is in the following example.


"""
