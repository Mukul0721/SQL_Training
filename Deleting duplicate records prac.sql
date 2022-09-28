Use TSQL2012
GO
EXEC sp_rename 'Car$','Cars'
create table cars
( id      int,
  model   varchar(50),
  brand   varchar(40),
  color   varchar(30),
  make    int
);
insert into cars values (1, 'Model S', 'Tesla', 'Blue', 2018);
insert into cars values (2, 'EQS', 'Mercedes-Benz', 'Black', 2022);
insert into cars values (3, 'iX', 'BMW', 'Red', 2022);
insert into cars values (4, 'Ioniq 5', 'Hyundai', 'White', 2021);
insert into cars values (5, 'Model S', 'Tesla', 'Silver', 2018);
insert into cars values (6, 'Ioniq 5', 'Hyundai', 'Green', 2021);
 Select * from cars

 --1.Delete Duplicate records From Cars Using Max fun
Delete from cars where id in( Select max(id) From cars
 Group By model,brand
 Having Count(1)>1)
 
 --2. Delete Duplicate records using Self Joins
 Delete from cars where id in(Select c2.id from cars c1
 Join cars c2 On c1.model = c2.model
 where c1.id <c2.id)

 Select * from cars
--3.Delete duplicate records using Min fun
delete from cars where id not in(Select min(id) from cars
Group by model,brand)
--4.Delete duplicate records using Window Fun
Select *,ROW_NUMBER() Over(partition by model,brand order by id) from cars
Select *,Rank() Over(partition by model,brand order by id) from cars
Delete from cars where id in (Select id from (
    Select *,DENSE_RANK() Over(partition by model,brand order by id) as Rn from cars) x
	Where x.Rn > 1)



delete a from cars a,cars b
where a.model=b.model and a.brand=b.brand and a.make=b.make
and a.id>b.id


with cte as
(
select *,DENSE_RANK()over(partition by model,brand,make order by id) d from cars)delete  from cte where d=2 

Select distinct model,brand from cars

Create table Nulls( Id int Not Null,Name Varchar(20) Null)
Select * from Nulls
Insert Into Nulls
Values(1,'Sam'),(2,'Null'),(3,'Sam'),(4,null)

Alter table Nulls
Alter column Name Varchar(20) Not Null

Truncate table Nulls


