
--This will bring up all the data for the AZHousing table. 
Select *
From AZhousingData
Order by City ASC
;
--This will bring up all the information for the Income table.
Select *
From Income
Order by City ASC
;
--This shows the average price of houses in Arizona according to Zillow.
Select avg(cast(Price as int)) as AverageAzHomePrice
From AZhousingData
;
--This will show the average home price by city in Arizona.
Select Avg(cast(Price as int)) as AverageHouseCost, City
From AZhousingData
Group by City
Order by City ASC
;
--This will show us what the highest average price of a home and what city it is found in.
Select City, Max(Price) as Highest
From AZhousingData
Group by City
Order by Highest Desc
;
--This will show us what the average square foot of a home is by its corresponding city.
Select City, Avg(convert(int, sqft)) as AvgSquareFeet
From AZhousingData
Group by City
Order by AvgSquareFeet Desc
;
--This will show me what the average household income is by City in Arizona ordered from the highest to lowest.
Select City, Avg(convert(int, MeanIncome)) as Average
From Income
where (StateName) = 'Arizona'
Group by City 
Order by Average Desc
;
--Here I have joined the Income and AZHome tables.
Select *
From AZhousingData as Az
Join Income as Inc
on Az.City = Inc.City
where Inc.StateName = 'Arizona'
Order by Az.City ASC
;
--Here I make a temporary table for the specific data selected.
drop table if exists #temp_AzHomesandIncome
create table #temp_AzHomesandIncome(
Price int,
City varchar(200),
MeanIncome bigint,
)
--Here I insert data into my temp table.
insert into #temp_AzHomesandIncome
Select Az.Price, Inc.City, Inc.MeanIncome
From AZhousingData as Az
Join Income as Inc
on Az.City = Inc.City
;
Select *
From #temp_AzHomesandIncome
;
--Here I can see the cities that have an average income above the average household income in Arizona.
Select City, cast(avg(MeanIncome)as Int) as AvgIncome
From #temp_AzHomesandIncome
Group by City
having avg(MeanIncome) > 61000
Order by AvgIncome DESC




