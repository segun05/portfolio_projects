/* where statement are =, IN,<>, NULL, NOT NULL, AND, OR, Like `*/ 
/*SELECT STATEMENT *, TOP, Distinct,  Count, as, Max, Min, Avg  */
/* joins */

select top 10 *
from Practice.dbo.[movie dataset]
where Revenue >= $108300000 ;
--
select top 10 --/ stores with highest nos of transactions
store_nbr, 
count(store_nbr) as count
from FraudCases.dbo.transactions
group by store_nbr
order by count desc;

--store with low transaction
select top 5
	 s.store_nbr
	, s.state
	, s.city
	, t.transactions
	, t.date
from FraudCases.dbo.stores as s
inner join FraudCases.dbo.transactions as t on 
s.store_nbr = t.store_nbr 
order by t.transactions;

select max(store_nbr)
from 
(
select store_nbr
, COUNT(transactions) transac_vol
from FraudCases.dbo.transactions 
where transactions > 300
Group by store_nbr
order by  transac_vol desc
);

select count(store_nbr)
from FraudCases.dbo.transactions

select top 2 *
from FraudCases.dbo.bank_loan

SELECT AVG(AGE) FROM FraudCases.dbo.bank_loan

select top 5* 
from FraudCases.dbo.[customer_shopping_data - Copy]
where Age <= 25  and gender Like'M%'  and payment_method = 'Cash';


select top 5 * from FraudCases.dbo.[customer_shopping_data - Copy]
where customer_id <> 'C266599';

select top 5 * from FraudCases.dbo.[customer_shopping_data - Copy]
where customer_id < 'C266599' or Age >=53


select top 5 * from FraudCases.dbo.[customer_shopping_data - Copy]
where customer_id in ( 'C266599' , 'C111565', 'C231025') or age <18 ;


select top 10 
[customer_id]
,[gender]
, count(quantity) over (partition by gender)
,[quantity]
,[price]
,[payment_method]
	--,count(category)
	from FraudCases.dbo.[customer_shopping_data - Copy]
where age between 18 and 25

--order by customer_id desc;

select  gender
 ,count(gender)from FraudCases.dbo.[customer_shopping_data - Copy]
where age between 18 and 25
group by gender
order by gender asc;

select  gender
	, age
	 ,count(gender) as total from FraudCases.dbo.[customer_shopping_data - Copy]
	where age between 18 and 25
group by gender, age
order by age desc, gender

select  gender
	, age
	
	 ,count(gender) as total from FraudCases.dbo.[customer_shopping_data - Copy]
	where age between 18 and 25
group by gender, age
order by age desc, gender

/* joins */
select top 5 * from dbo.stores
select top 5 * from dbo.transactions;

select  * 
from dbo.stores as s
right outer join dbo.transactions as t on s.store_nbr = t.store_nbr
--group by store_nbr
order by s.store_nbr;

/*select  * 
from dbo.stores as s
union
select * from dbo.transactions as t --on s.store_nbr = t.store_nbr
--group by store_nbr
order by s.store_nbr; --using a UNION, INTERSECT or EXCEPT operator must have an equal number of expressions in their target lists.*/


select  s.store_nbr
	--, count(s.store_nbr)
	, s.city
	, s.[state]
	, t.[date]
	, t.transactions
from dbo.stores as s
right outer join dbo.transactions as t on s.store_nbr = t.store_nbr
where transactions >= 2000
--group by s.store_nbr
order by s.store_nbr;

/* find total trasactions by store nos */
select  s.store_nbr
		, count(t.transactions) as trasactions
from dbo.stores as s
 join dbo.transactions as t on s.store_nbr = t.store_nbr
group by s.store_nbr

/* find total  value of trasactions by store nos */
select  s.store_nbr
		, count(t.transactions) as trasactions
from dbo.stores as s
 join dbo.transactions as t on s.store_nbr = t.store_nbr
group by s.store_nbr;

select store_nbr,
avg(transactions) avgTransac
from fraudCases.dbo.transactions
group by store_nbr
order by avgTransac;


select store_nbr,
max(transactions) maxTransac
from fraudCases.dbo.transactions
group by store_nbr
order by maxTransac desc;-- store 44 has the most sales


select  *
from Practice.dbo.cars;

select *
from Practice.dbo.cars
where Fuel_Type = 'Petrol' and Seller_Type = 'Individual' 
and Transmission = 'Automatic' and selling_price > 1.5;

select AVG(Selling_Price) avg_sellingP
from Practice.dbo.cars;

select car_name	, Year, Transmission, Present_Price
from Practice.dbo.cars
where Selling_Price >= (select avg(Selling_Price) 
from Practice.dbo.cars)and Transmission ='Automatic'
order by Year desc, car_name desc;
 
/* CASE statement*/
-- select car_name, Year, Transmission, Present_Price,selling_price,
-- (case 
--	when present_price >=30 then 'expensive'
--	when present_price <=30 then 'cheap'
--	else  'affordable'
-- end
-- ) as mkt_value
--from Practice.dbo.cars
--where Present_price is not null
--order by present_price;

select *,
(case
	when transmission = 'Automatic' then present_price + (present_price*.10)
	when transmission = 'manual' then present_price + (present_price*.050)
	end
	) as new_PP
	,
(case 
		when present_price >=30 then 'expensive'
		when present_price <=30 then 'cheap'
		else  'affordable'
end
 ) as mkt_value
from  Practice.dbo.cars
order by mkt_value desc;

SELECT top 5 store_nbr,
count(transactions)total_trasac
,sum(transactions) as transac_value
FROM FraudCases.dbo.transactions
group by store_nbr
order by transac_value desc
; --find top 5 store with highest transac_value

--- identify the 10th best performing store in trasac_value?

select store_nbr,
count(transactions)total_trasac
,sum(transactions) as transac_value
from FraudCases.
.transactions
group by store_nbr
order by transac_value desc
offset 9 rows
fetch next 1 row only; -- using offset goes along with fetch next row and no use of top / limit

select store_nbr,
count(transactions)total_trasac
,sum(transactions) as transac_value,
case 
	when transactions >250000 then 'most_profitable'
	when transactions between 100000 and 250000 then 'profitable'
	when transactions < 100000 and transactions >50000 then 'breakeven'
	else 'loss'
	end
from FraudCases.dbo.transactions
group by store_nbr


select top 5 * from Practice.dbo.meningitis_dataset
where id not null

select  t.store_nbr
	,s.cluster
	, s.city
	, s.state 
	, t.transactions
	, sum(t.transactions) over (partition by s.cluster) as transc_clstr
	, avg(t.transactions) over (partition by s.cluster) as avg_transc
	, max(t.transactions) over (partition by s.cluster) as max_transc
	, min(t.transactions) over (partition by s.cluster) as min_transc
	, (t.transactions) - avg(t.transactions)  over (partition by s.cluster) as avg_diff
from FraudCases.dbo.stores as s
inner join FraudCases.dbo.transactions as t
on s.store_nbr =t.store_nbr
order by s.cluster



select t.store_nbr, s.cluster
	, sum(t.transactions) total_trans
	,avg(t.transactions) avg_trans
		, min(t.transactions) min_trans
		, max(t.transactions)max_trans
from[dbo].[stores] as s
inner join [dbo].[transactions] as t
on s.store_nbr = t.store_nbr
where t.transactions > 1000
group by t.store_nbr,  s.cluster
order by  total_trans desc
--offset 2 row 
--fetch next 1 rows only;

select [category]
--[customer_id]
,[gender]
, quantity
, sum(quantity) over (partition by gender) sum_qty
,avg(quantity) over (partition by gender) avg_qty
,max(quantity) over (partition by gender) max_qty
,[price]
,[payment_method]
	--,count(category)
	from FraudCases.dbo.[customer_shopping_data - Copy]
where age between 18 and 25


select [gender]
, [shopping_mall]
	, sum(quantity) as total_qty
	,avg(quantity) as avg_qty
	from [dbo].[customer_shopping_data - Copy]
	group by gender, [shopping_mall]
	order by total_qty desc, [shopping_mall];


select 
[gender]
,  COUNT(gender) over (partition by category)as sex
, [shopping_mall]
, category
, [payment_method]
, [price]
, round(sum(price) over (partition by category),2)total_price
, round(avg(price) over (partition by category),2) as avg_price
	, sum(quantity) over (partition by category)as total_qty
	,avg(quantity) over (partition by category)as avg_qty
	,max(quantity) over (partition by category)as max_qty
	,min(quantity) over (partition by category)as min_qty	
	--, [quantity]- avg(quantity) over (partition by category) as diff_avg
	from [dbo].[customer_shopping_data - Copy]
	where age >= 40 
	order by total_qty desc, [shopping_mall],[gender]
	
	--- CTE. nb you run everything together

	with CTE_shopping as 
	(
	select [gender]
, [shopping_mall]
	, sum(quantity) as total_qty
	,avg(quantity) as avg_qty
	from fraudCases.[dbo].[customer_shopping_data - Copy]
	group by gender, [shopping_mall]
	--order by total_qty desc, [shopping_mall];
	
	)
	select *
	from CTE_shopping

	---#TEMP TABLE
	drop table if exists #temp_shopping
	 create table #temp_shopping (
	[customer_id] nvarchar (100)
	,[gender] varchar (100)
	,[age] int
	,[category] varchar (100)
	,[quantity]int
	, [price] float
	 )

	alter table #temp_shopping 
	drop column [customer_id] -- cos of error i drop this column
	
		alter table #temp_shopping 
	add [customer_id] nvarchar (100)

	 insert into #temp_shopping 
	 select[customer_id] 
	,[gender] 
	,[age] 
	,[category] 
	,[quantity]
	, [price] 
	from FraudCases.[dbo].[customer_shopping_data - Copy]
	 where age >= 50;

	 select top 8 *
	 from #temp_shopping

	create procedure Test 
	as 
	(select
	    age
	  , category
	  ,   count(quantity) qty
	  from #temp_shopping 
	  group by age, category
	 -- order by  qty desc;
	  )
	 -- exec sp_rename '#temp_shopping.gender', '[customer_id]'

	   select
	    age
	  , category
	  , gender
	 -- ,   count(quantity) over (partition by gender) 
	  , avg(price) over (partition by gender)
	--  , sum(price) over (partition by category)
	  from #temp_shopping 
	 -- group by age, category
	 -- order by  qty desc;

	 exec test

	 create procedure temp_shopping
	 as 
	  create table #temp_shopping (
	[customer_id] nvarchar (100)
	,[gender] varchar (100)
	,[age] int
	,[category] varchar (100)
	,[quantity]int
	, [price] float
	 )
	  insert into #temp_shopping 
	 select[customer_id] 
	,[gender] 
	,[age] 
	,[category] 
	,[quantity]
	, [price] 
	from FraudCases.[dbo].[customer_shopping_data - Copy]
	 where age >= 50;

 select  *
	 from #temp_shopping

	 exec [sys].[sp_views_rowset2]

	 select top 5 *
	 from fraudcases.[dbo].[bank_loan];

 select age, income, (select avg(income) from fraudcases.[dbo].[bank_loan] ) as allAvg
 from fraudcases.[dbo].[bank_loan]
 order by age 

 select age, income, avg(income) over (partition by age ) as allAvg
 from fraudcases.[dbo].[bank_loan]
 order by age ;

 select age, income, (select avg(income) from fraudcases.[dbo].[bank_loan] ) as allAvg,
 avg(income) over (partition by age ) ind_avg
 from fraudcases.[dbo].[bank_loan]
 order by age;

select  id, age, income , education
from fraudcases.[dbo].[bank_loan]
where income < (select avg(income) from fraudcases.[dbo].[bank_loan] where family >= 4)
order by Age;


select  a.id, a.age, ind_avg
from ( select id, age, income, avg(income) over ( )as ind_avg from fraudcases.[dbo].[bank_loan])a
-- if u mention column in the subquery then you must alias them in the main query

select top 800 *
from [PortfolioProject].[dbo].[covidvaccination]

select a.location, a.date, a.total_cases
from [PortfolioProject].[dbo].[coviddeath] ;

select  iso_code,location, date, total_cases, new_cases, nullif(total_deaths,0)tota_death, population
from [PortfolioProject].[dbo].[allCoviddata] 
order by 1,2
select location, continent
from [PortfolioProject].[dbo].[allCoviddata]
where location in ('world', 'africa','Low-income countries', 'high-income countries' , 'upper-middle-income countries', 'Lower-middle-income countries'
,'europe','north america','asia','south america','european union (27)')
order by continent;



--Data exploration
---- total cases vs total deaths
select  location,date, total_cases as total_cases, total_deaths, total_deaths/nullif(total_cases,0)*100 as death_percentage
from [PortfolioProject].[dbo].[allCoviddata] 
where location like '%state%'
order by 1,2

--nb u can use cast() column  as int) to change data type

--- total cases vs population
select  location,date, total_cases , total_deaths, population,total_cases/nullif(population,0)*100 as cases_percentage
from [PortfolioProject].[dbo].[allCoviddata] 
--where location like '%cana%'
order by 1,2

-- country with max cases and percentage
select location, population,  max(total_cases) highest_cases,max(total_cases/population)*100 as perc_cases
from [PortfolioProject].[dbo].[allCoviddata] 
group by location, population
order by perc_cases  desc

select location, population,  max(cast(total_deaths as int)) highest_deaths,max(total_deaths/population)*100 as perc_death
from [PortfolioProject].[dbo].[allCoviddata] 
group by location, population
order by perc_death  desc

--remove un needed data with the where and not in clause 

select location,  max(cast(total_deaths as int)) as highest_deaths
from [PortfolioProject].[dbo].[allCoviddata] 
where location not in ('world', 'africa','Low-income countries', 'high-income countries' , 'upper-middle-income countries', 'Lower-middle-income countries'
,'europe','north america','asia','south america','european union (27)')  and continent !=' '
group by location
order by highest_deaths  desc; 

select continent,  max(cast(total_deaths as int)) as highest_deaths
from [PortfolioProject].[dbo].[allCoviddata] 
where location not in ('world', 'africa','Low-income countries', 'high-income countries' , 'upper-middle-income countries', 'Lower-middle-income countries'
,'europe','north america','asia','south america','european union (27)') and continent !=' '
group by continent
order by highest_deaths  desc;


-- global daily cases and deaths and percentage
select --date, 
sum(new_cases)as totalcase , sum(cast(new_deaths as int)) as totaldeath, sum(cast(new_deaths as int))/sum(nullif(new_cases, 0))*100 as newdeathperc
from [PortfolioProject].[dbo].[allCoviddata]
--group by date
order by 1

---total population vs vaccination with assumption that 2 tables are joined e.g death & vaccination
--- rolling sum
select continent, location, date, population, convert( int,new_vaccinations) new_vaccinations,
sum(convert( float,new_vaccinations)) over (partition by location order by location , date) as rollingtotalvac
--sum(convert( int,new_vaccinations)/population)*100 as perc
from [PortfolioProject].[dbo].[allCoviddata] 
where location not in ('world', 'africa','Low-income countries', 'high-income countries' , 'upper-middle-income countries', 'Lower-middle-income countries'
,'europe','north america','asia','south america','european union (27)') and continent !=' '
order by 2,3

-- to do calculation on the new column created e.g rollingtotal u need to use CTE

with popvsvac (continent,location, date,  population, new_vaccinations,rollingtotalvac )
as(
select continent, location, date, population, convert( int,new_vaccinations) new_vaccinations,
sum(convert( float,new_vaccinations)) over (partition by location order by location , date) as rollingtotalvac
--sum(convert( int,new_vaccinations)/population)*100 as perc
from [PortfolioProject].[dbo].[allCoviddata] 
where location not in ('world', 'africa','Low-income countries', 'high-income countries' , 'upper-middle-income countries', 'Lower-middle-income countries'
,'europe','north america','asia','south america','european union (27)') and continent !=' '
)

select *, rollingtotalvac/population as perc
from popvsvac

--- temp table
drop table if exists #temp_popvsvac  --- used if u want to add or remove from the temp table
create table #temp_popvsvac(
continent nvarchar (50), 
location nvarchar (50), 
date date,
population numeric,
new_vaccinations float,
rollingtotalvac numeric
)

insert into #temp_popvsvac

select continent, location, date, population, convert( int,new_vaccinations) new_vaccinations,
sum(convert( float,new_vaccinations)) over (partition by location order by location , date) as rollingtotalvac
--sum(convert( int,new_vaccinations)/population)*100 as perc
from [PortfolioProject].[dbo].[allCoviddata] 
where location not in ('world', 'africa','Low-income countries', 'high-income countries' , 'upper-middle-income countries', 'Lower-middle-income countries'
,'europe','north america','asia','south america','european union (27)') and continent !=' '

select *, rollingtotalvac/population as perc
from #temp_popvsvac;
 

 ---  create view for data to use in visualization
 ---percent of population vaccinated

create view  PopvsVaccination as
select continent, location, date, population, convert( int,new_vaccinations) new_vaccinations,
sum(convert( float,new_vaccinations)) over (partition by location order by location , date) as rollingtotalvac
--sum(convert( int,new_vaccinations)/population)*100 as perc
from [PortfolioProject].[dbo].[allCoviddata] 
where location not in ('world', 'africa','Low-income countries', 'high-income countries' , 'upper-middle-income countries', 'Lower-middle-income countries'
,'europe','north america','asia','south america','european union (27)') and continent !=' ' and continent is not null


select * from PopvsVaccination