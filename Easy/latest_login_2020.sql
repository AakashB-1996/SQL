# Write your MySQL query statement below
select user_id, max(time_stamp) as last_stamp from Logins  ##select the latest date per userID
where year(time_stamp) = '2020'  ##Filter the year to 2020
group by user_id
