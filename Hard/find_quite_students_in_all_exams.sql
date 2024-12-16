# Write your MySQL query statement below
with max_min as (
    select exam_id,student_id,score,max(score) over(partition by exam_id ) as mx,
    min(score) over(partition by exam_id ) as mi from Exam
), ##Find max and min scores for each subject
sub as (select distinct student_id from Exam where student_id not in (
select distinct student_id from max_min where score = mx or score = mi)) ##Filter out anyone who ever score the max or min
select * from Student where student_id in (select * from sub) order by student_id

"""
Table: Student

+---------------------+---------+
| Column Name         | Type    |
+---------------------+---------+
| student_id          | int     |
| student_name        | varchar |
+---------------------+---------+
student_id is the primary key (column with unique values) for this table.
student_name is the name of the student.
 

Table: Exam

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| exam_id       | int     |
| student_id    | int     |
| score         | int     |
+---------------+---------+
(exam_id, student_id) is the primary key (combination of columns with unique values) for this table.
Each row of this table indicates that the student with student_id had a score points in the exam with id exam_id.
 

A quiet student is the one who took at least one exam and did not score the highest or the lowest score.

Write a solution to report the students (student_id, student_name) being quiet in all exams. Do not return the student who has never taken any exam.

Return the result table ordered by student_id.

"""
