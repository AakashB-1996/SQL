#Write your MySQL query statement below

##removes any duplicates of the same post being reported as spam
with reported_dis as (
select 
distinct 
action_date, post_id,
extra from actions
),
## Counts number of spams being reported per day
reported as (
select 
action_date,
sum(
    case when extra = 'spam' then 1 else 0 end
) as spammed
from reported_dis
group by 1 
having sum(
    case when extra = 'spam' then 1 else 0 end
) >0
),
##counts the number of those spams being removed
removed as (
select 
        a.action_date,
        coalesce(count( r.post_id),0) as remove
        from reported_dis a left join removals r
        on a.post_id = r.post_id where a.extra = 'spam'
        group by 1
),
##Calculate the ratio
final as (
select 
r.action_date,
(r.remove/re.spammed)*100 as ratio
from removed r, reported re where r.action_date = re.action_date
)
##Report the result
select round(avg(ratio),2) as average_daily_percent from final;
