# Write your MySQL query statement below
with sub as (
    select
    p.project_id,
    p.employee_id,
    dense_rank() over(partition by p.project_id order by e.experience_years desc) as rnk
    from 
    Project p, Employee e
    where p.employee_id = e.employee_id
) ##rank employess based on experience in every project
select project_id, employee_id from sub where rnk = 1  ##select the top ranked employees

  
"""
Table: Project

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| project_id  | int     |
| employee_id | int     |
+-------------+---------+
(project_id, employee_id) is the primary key (combination of columns with unique values) of this table.
employee_id is a foreign key (reference column) to Employee table.
Each row of this table indicates that the employee with employee_id is working on the project with project_id.
 

Table: Employee

+------------------+---------+
| Column Name      | Type    |
+------------------+---------+
| employee_id      | int     |
| name             | varchar |
| experience_years | int     |
+------------------+---------+
employee_id is the primary key (column with unique values) of this table.
Each row of this table contains information about one employee.
 

Write a solution to report the most experienced employees in each project. In case of a tie, report all employees with the maximum number of experience years.

Return the result table in any order.
"""
