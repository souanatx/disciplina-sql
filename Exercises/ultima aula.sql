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
from Person.Person
order by 5


-----------------------------
---- WHERE + OperadorLogico ----
-- operador igual = --

select *
from Sales.SalesPerson
where TerritoryID = 2

-- contabilizar o número de linhas de uma tabela com filtro where TerritoryID = 6

select COUNT (*) as 'Contabilizador' -- alias (ou seja, estamos a renomear esta coluna)
from Sales.SalesPerson
where TerritoryID = 6

----------------------------
-- operador diferente != ou <> -- retira não só o filtro desejado, mas também retira automaticamente os dados a NULL
select *
from Sales.SalesPerson
where TerritoryID != 6 

select *
from Sales.SalesPerson
where TerritoryID <> 6 -- fazer isto ou aquilo fornece exatamente a mesma solução

----------------------------
-- operador menor e maior < / > --
select BusinessEntityID,
		TerritoryID,
		CommissionPct
from Sales.SalesPerson
where CommissionPct < '0.018' -- se colocar virgula o resultado é diferente

----------------------------
-- operador maior ou igual --
select BusinessEntityID,
		TerritoryID,
		CommissionPct
from Sales.SalesPerson
where CommissionPct >= '0.018' 

----------------------------
-- operador BETWEEN -- Retorna um range de valores
select *
from Sales.SalesPerson
where Bonus between '2000.00' and '5150.00' 
order by Bonus

-- distinct - retornar dados da coluna sem repetições

select distinct SafetyStockLevel
from Production.Product

select *
from Production.Product
where SafetyStockLevel between 800 and 1000
order by SafetyStockLevel

-- distinct

select distinct Color
from Production.Product

-- clausula AND e OR

select*
from Production.Product
where Color = 'Black' and MakeFlag = 0

select*
from Production.Product
where Color = 'Black' or MakeFlag = 0

-- NOT

select *
from Production.Product
where not Color = 'Black'

-- LIKE

select *
from Production.Product
where Name like '%Crankarm' -- palavra na posição final da célula

select *
from Production.Product
where Name like 'Adjustable%' -- palavra na posição inicial

select *
from Production.Product
where Name like '%able%' -- palavra na posição inicial, intermédia ou final


-- TOP -- utilizado para ver determinadas linhas só para ver a estrutura da tabela por exemplo

select *
from Person.Person
-- kill spid -- matar a transação quando há demasiadas listas e bloqueia

select top 5 *
from Person.Person
-- ou
select top 100 *
from Person.Person


--------------------------
-- with nolock --

select *
from Person.Person nolock -- The nolock hint is a specific hint used in Microsoft SQL Server that allows a query to read data from a table without acquiring a lock on it. This can improve query performance, but it can also cause the query to return dirty or inconsistent data. It is generally not recommended to use the nolock hint unless you have a very specific reason for doing so.


--------------------------
-- Joins --

select *
from Person.Person P with(nolock)
inner join Person.BusinessEntity BE with(nolock)
	on P.BusinessEntityID = Be.BusinessEntityID

--------------------------
-- NULL --

select *
from Person.Person
where Title is null

--------------------------
-- WILDCARD --

select *
from Person.Person
where FirstName like '[KTR]%' -- retorna todos os nomes começados por K, T e R
order by FirstName

select *
from Person.Person
where FirstName like '[^KTR]%' -- retorna todos os nomes NÃO começados por K, T e R
order by FirstName

--------------------------
-- UPPER e  LOWER --

select FirstName,
		UPPER(FirstName) as 'Maiscula',
		LastName,
		LOWER (LastName) as 'Minuscula'
from Person.Person

---------------------------
-- len e datalength -- são diferentes

select FirstName,
		len (FirstName) as 'len',
		LastName,
		datalength (LastName) as 'datalength'
from Person.Person

---------------------------
-- Reverse --
select FirstName,
		Reverse (FirstName) as 'reverse'
from Person.Person

----------------------------
-- Replace --
select LastName,
		REPLACE(LastName, 'a', 'z') as 'Substituir A por Z',
		REPLACE(LastName, 'a', 'WW') as 'Substituir A por WW',
		REPLACE(LastName, 'a', '') as 'Substituir A por VAZIO'
from Person.Person

----------------------------
-- GETDATE() sysdatetime() --
Select GETDATE()
Select sysdatetime() -- é utilizado no oraculo


----------------------------
-- dateadd() -- Acrescentar período temporal
select OrderDate,
		DATEADD(Year, 1, OrderDate) as 'Mais 1 ano',
		DATEADD(Month, 1, OrderDate) as 'Mais 1 mês',
		DATEADD(Day, 1, OrderDate) as 'Mais 1 dia',
		DATEADD(Day, -1, OrderDate) as 'Menos 1 dia'
from Sales.SalesOrderHeader

----------------------------
-- datediff() -- Diferença de período temporal

select OrderDate,
		Getdate() as 'Data atual',
		Datediff(Year,OrderDate,GETDATE()) as 'Diferença YYYY',
		Datediff(Month,OrderDate,GETDATE()) as 'Diferença MM',
		Datediff(Day,OrderDate,GETDATE()) as 'Diferença DD'
from Sales.SalesOrderHeader

-----------------------------
-- Função year/month/day() --

select OrderDate,
		Year(OrderDate) as 'ANO',
		Month(OrderDate) as 'MÊS',
		Day(OrderDate) as 'DIA'
from Sales.SalesOrderHeader

-----------------------------
-- CONCATENAÇÃO --

select 'ab' + ' ' + 'c'

select FirstName,
		LastName,
		FirstName + ' ' + LastName as 'PrimeiroUltimoNome'
from Person.Person

-----------------------------
-- CONCAT --

select Concat('Olá', ' ', 'Mundo') as 'teste'

-----------------------------
-- Criação de variáveis --

declare @a varchar (39) = 'A minha data de nascimento é '
declare @b date = '02/28/1990'

select concat(@a, @b) as 'Resultado'

-----------------------------
-- CASE --

select distinct Title
from Person.Person

select title, 
		case title
			when 'Mr.' then 'Male'
			when 'Ms.' then 'Female'
			when 'Mrs.' then 'Female'
			when 'Sra.' then 'Female'
			when 'Sr.' then 'Male'
			else 'Unknown'
		end as 'Género'
from Person.Person

-----------------------------
-- IIF --

declare @c int = 50
declare @d int = 25

select IIF(@c < @d, 'True', 'False')
select IIF(@c > @d, 'True', 'False')

-----------------------------
-- FERRAMENTAS ADMINISTRATIVAS --

select @@VERSION,
		DB_ID() as 'id_DB',
		DB_NAME() as 'Name_DB',
		SUSER_NAME() as 'Login'

