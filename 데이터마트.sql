select SUBSTRING(event_time,0,11)
from ondb_bi.jy_test_ecomerce_data
group by SUBSTRING(event_time,0,11)

select *
from ondb_bi.jy_test_ecomerce_data
order by category_id
limit 40

select search(category_code,".")
from ondb_bi.jy_test_ecomerce_data

select *
from ondb_bi.jy_test_ecomerce_data
where user_session ='c7385964-0787-4980-b0fb-3efd861f0d61'

where category_id ='2053013563810775923'

select event_type
from ondb_bi.jy_test_ecomerce_data
group by event_type

select category_id,category_code ,sum(price)
from ondb_bi.jy_test_ecomerce_data
where event_type ='purchase'
group by category_id ,category_code

select category_id,category_code
from ondb_bi.jy_test_ecomerce_data
group by category_id,category_code

select *
from ondb_bi.jy_test_ecomerce_data
order by category_id
limit 40

with di_cate as (
select category_id, SPLIT_PART(category_code, '.', 1) depth_1 , SPLIT_PART(category_code, '.', 2) depth_2, SPLIT_PART(category_code, '.', 3) depth_3, SPLIT_PART(category_code, '.', 4) depth_4
from ondb_bi.jy_test_ecomerce_data
group by category_id, category_code
)

select brand
from ondb_bi.jy_test_ecomerce_data
group by brand

select TO_TIMESTAMP(event_time,'YYYY-MM-DD HH24:MI:SS') + INTERVAL '9 hour', event_time
from ondb_bi.jy_test_ecomerce_data
limit 20

select TO_TIMESTAMP(event_time,'YYYY-MM-DD HH24:MI:SS'),TO_DATE(event_time,'YYYY-MM-DD'),to_char(TO_TIMESTAMP(event_time,'YYYY-MM-DD HH24:MI:SS'),'HH24')
from ondb_bi.jy_test_ecomerce_data

select brand,rank() over (partition by brand, order by tot_sum)
from(
select brand,event_type, case when event_type !='purchase' then 0 else ROUND(sum(price),1) end tot_sum,count(event_type) event_count
from ondb_bi.jy_test_ecomerce_data
group by brand,event_type
)

- -일자별 매출

select to_char(TO_TIMESTAMP(event_time,'YYYY-MM-DD HH24:MI:SS'),'yyyy-mm') std_ym, TO_DATE(event_time,'YYYY-MM-DD') std_dt,to_char(TO_TIMESTAMP(event_time,'YYYY-MM-DD HH24:MI:SS'),'HH24') dtime, round(sum(price),1)
from ondb_bi.jy_test_ecomerce_data
where event_type = 'purchase'
group by std_ym,std_dt, dtime
order by std_ym,std_dt, dtime