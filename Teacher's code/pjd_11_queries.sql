---- Alocar à BD desejada ----

use AdventureWorks2019
go

------------------------------
---- ORDER BY ----

select *
from person.Person
order by FirstName --asc

select *
from person.Person
order by FirstName desc

select *
from person.Person
order by 5

------------------------------
---- WHERE + OperadorLogico ----
-- operador igual = ---
select * 
from Sales.SalesPerson
where TerritoryID = 6

select * 
from Sales.SalesPerson
where TerritoryID = 2

-- contabilizar o numero de linhas de um tablea com filtro where TerritoryID = 6

select COUNT(*) as 'Contabilizador' -- alias
from Sales.SalesPerson
where TerritoryID = 6

------------------------------
-- operador diferente != / <> --- retira não o filtro que desajamos + os dados a NULL

select * 
from Sales.SalesPerson
where TerritoryID != 6

select * 
from Sales.SalesPerson
where TerritoryID <> 6

------------------------------
-- operador menor e maior < / > ---

select BusinessEntityID,
	   TerritoryID,
	   CommissionPct
from Sales.SalesPerson
where CommissionPct < '0.018'

--select BusinessEntityID,
--	   TerritoryID,
--	   CommissionPct
--from Sales.SalesPerson
--where CommissionPct < '0,018'

select BusinessEntityID,
	   TerritoryID,
	   CommissionPct
from Sales.SalesPerson
where CommissionPct > '0.018'

------------------------------
-- operador menor/igual e maior/igual <= / >= ---

select BusinessEntityID,
	   TerritoryID,
	   CommissionPct
from Sales.SalesPerson
where CommissionPct <= '0.018'

select BusinessEntityID,
	   TerritoryID,
	   CommissionPct
from Sales.SalesPerson
where CommissionPct >= '0.018'

------------------------------
-- operador BETWEEN -- Retorna um range de valores

select *
from   Sales.SalesPerson
where  Bonus between '2000.00' and '5150.00'
order by Bonus

-- distict - retornar dados da coluna sem repetições

select distinct SafetyStockLevel
from   Production.Product

-- operador BETWEEN -- Retorna um range de valores

select *
from   Production.Product
where SafetyStockLevel between 800 and 1000
order by SafetyStockLevel 

--- distinct 

select distinct Color
from   Production.Product


--- clausula AND e OR
select *
from   Production.Product
where  Color = 'Black' and MakeFlag = 0

select *
from   Production.Product
where  Color = 'Black' or MakeFlag = 0


-- NOT

select *
from Production.Product
where not Color = 'Black'

-- LIKE 

select *
from Production.Product
where [Name] like '%Crankarm' -- palavra na posição final

select *
from Production.Product
where [Name] like 'Adjustable%' -- palavra na posição inicial

select *
from Production.Product
where [Name] like '%Adjustable%' -- palavra na posição inicial ou intermédia ou final

--- TOP ---

select top 5 *
from Person.Person

select top 100 *
from Person.Person

------------------
--- Nolock ---

select *
from Person.Person Nolock

------------------
--- Joins ---

select *
from Person.Person P with(nolock)
inner join Person.BusinessEntity BE with(nolock)
	on P.BusinessEntityID = BE.BusinessEntityID

------------------
--- NULL ---

select *
from person.Person
where Title is null

------------------
--- WILDCARD ---

select *
from person.Person
where FirstName like '[KTR]%' -- retorna todos os nomes começados por K,T,R
order by FirstName

select *
from person.Person
where FirstName like '[^KTR]%' -- retorna todos os nomes NÃO começados por K,T,R
order by FirstName

------------------
--- UPPER e LOWER ---

select FirstName, 
	   UPPER(FirstName) as 'Maiuscula',
	   LastName, 
	   LOWER(LastName) as 'Minuscula'
from Person.Person

------------------
--- len e datalength ---

select FirstName, 
	   len(FirstName) as 'len',
	   LastName, 
	   datalength(LastName) as 'datalength'
from Person.Person

------------------
--- reverse ---

select FirstName, 
	   Reverse(FirstName) as 'Reverse'
from Person.Person

------------------
--- replace ---

select LastName, 
	   REPLACE(LastName,'a','z') as 'Substituir A por Z',
	   REPLACE(LastName,'a','WW') as 'Substituir A por WW',
	   REPLACE(LastName,'a','') as 'Substituir A por VAZIO'
from Person.Person

------------------
--- GETDATE() sysdatetime() ---

Select GETDATE()
Select sysdatetime()


------------------
--- dateadd() --- Acrescentar periodo temporal

select OrderDate, 
	   DATEADD(YEAR,1,OrderDate) as 'Mais 1 Ano',
	   DATEADD(MONTH,1,OrderDate) as 'Mais 1 mês',
	   DATEADD(DAY,1,OrderDate) as 'Mais 1 dia',
	   DATEADD(DAY,-1,OrderDate) as 'Menos 1 dia'
from Sales.SalesOrderHeader

------------------
--- datediff() --- Diferença de periodo temporal

select OrderDate, 
	   GETDATE() as 'Data Actual',
	   DATEDIFF(YEAR,OrderDate,GETDATE()) as 'Diferença YYYY',
	   DATEDIFF(MONTH,OrderDate,GETDATE()) as 'Diferença MM',
	   DATEDIFF(DAY,OrderDate,GETDATE()) as 'Diferença DD'
from Sales.SalesOrderHeader

------------------
--- Função year/month/day() --- 

select OrderDate, 
	   YEAR(OrderDate) as 'ANO',
	   MONTH(OrderDate) as 'MÊS',
	   DAY(OrderDate) AS 'DIA'
from Sales.SalesOrderHeader

------------------
--- CONCATENAÇÃO --- 

select 'MANUELA ' + ' ' + 'MARTINS'

select BusinessEntityID, 
	   FirstName, 
	   LastName, 
	   FirstName + ' ' + LastName as 'PrimeiroUltimoNome'
from Person.Person

------------------
--- CONCAT --- 

select CONCAT('OLÁ',' ', 'MUNDO') as 'teste'

--Criação de variaveis

declare @a varchar(30) = 'A minha data de nascimento é '
declare @b date = '02/28/1990'

select CONCAT(@a, @b) as 'Resultado' 

------------------
--- CASE --- 

select distinct Title
from Person.Person

select title,
			case title 
					when 'Mr.' then 'Male'
					when 'Mrs.' then 'Female'
					when 'Sra.' then 'Female'
					when 'Ms' then 'Female'
					when 'Ms.' then 'Female'
					else 'Unknown'
			end as 'Género'
from Person.Person

------------------
--- IIF --- 

declare @c int = 50
declare @d int = 25

select IIF(@c<@d, 'True', 'False')
select IIF(@c>@d, 'True', 'False')


------------------
--- FERRAMENTAS ADMINISTRATIVAS  ---

select @@VERSION,
	   DB_ID() as 'id_DB',
	   DB_NAME() as 'Name_DB',
	   SUSER_NAME() as 'Login'
