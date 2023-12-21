select*
from clothingdataset

----Which clothing brands have the highest and lowest sales revenue?
---for the highest sales revenue
select brand,sum(price_usd) as totalrev
from clothingdataset
group by brand
order by totalrev desc

-- for the lowest sales revenue
select brand,description,sum(price_usd) as totalrev
from clothingdataset
group by brand,description
order by totalrev asc


--top 3 selling brands for male
with top3 as(
select description, brand,type,sum(price_usd) as totalrev,
DENSE_RANK()over(order by sum(price_usd) desc) as toprank
from clothingdataset
where type ='mens'
group by brand,type,description
)

select brand,type,totalrev,toprank,description
from top3
where toprank<= 3

---top 3 selling brands for female
with top3 as(
select description,brand,type,sum(price_usd) as totalrev,
DENSE_RANK()over(order by sum(price_usd) desc) as toprank
from clothingdataset
where type ='womens'
group by brand,type,description
)

select brand,type,totalrev,toprank,description
from top3
where toprank<= 3