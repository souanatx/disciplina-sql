/*
Hierarquia de objectos SQL SSMS

INSTANCIA -- BASEDADOS -- OBJECTOS -- DADOS

CONJUNTOS DE QUERYS
.DML - DATA MANIPULATION LANGUAGE - COMANDOS DE INSERT, UPDATE, DELETE e TRUNCATE
.DDL - DATA DEFINITION LANGUAGE - COMANDOS CREATE, ALTER e DROP
.DQL - DATA QUERY LANGUAGE - SELECT 
*/

-- CRIAÇÃO DE BASE DADOS

CREATE DATABASE STORE
GO

-- USO DE BASE DADOS

use STORE
go

-- CRIAÇÃO DE SCHEMAS 

CREATE SCHEMA Clientes authorization [dbo]
go

CREATE SCHEMA Produtos authorization [dbo]
go

-- CRIAÇÃO DE MODELO DE DADOS

-- CRIAÇÃO DE TABELAS E RELACIONAMENTOS

-- CRIAÇÃO DE TABELA CLIENTES

drop table if exists Clientes.Cliente
go 

create table Clientes.Cliente(
Id int identity(1,1) not null constraint [PK_Cliente_Id] primary key clustered, -- integridade
-- regras de negocio
Pnome varchar(20) not null,  
Unome varchar(20) not null, 
Dtnasc date null, -- dd-mm-aaaa
-- monitorização/controlo
LastModifiedDate datetime2(3) not null constraint [DF_Cliente_LastModifiedDate] default getdate(), 
LastModifiedUser varchar(20) not null
)

-- CRIAÇÃO DE TABELA INFOCLIENTES

drop table if exists Clientes.InfoCliente
go 

create table Clientes.InfoCliente(
Id int identity(1,1) not null constraint [PK_InfoCliente_Id] primary key clustered, -- integridade
-- regras de negocio
Salario decimal(10,4) null, -- EXEMPLO: 111111,1111 
Morada varchar(50) not null, 
Localidade varchar (20) not null, 
CodPostal varchar(10) not null,
-- Relacionamento (FK)
ClienteId int not null, 
-- monitorização/controlo
LastModifiedDate datetime2(3) not null constraint [DF_InfoCliente_LastModifiedDate] default getdate(), 
LastModifiedUser varchar(20) not null
)

-- RELACIONAMENTO FK (FK(Coluna caracter não especial) <-> PK)

alter table Clientes.InfoCliente add constraint [FK_InfoCliente_ClienteId] 
foreign key (ClienteId) references Clientes.Cliente(Id)

-- CRIAÇÃO DE TABELA PRODUTO

drop table if exists Produtos.Produto
go 

create table Produtos.Produto(
Id int identity(1,1) not null constraint [PK_Produto_Id] primary key clustered, -- integridade
-- regras de negocio
Nome varchar(20) not null, 
DescProduto varchar(20) null, 
-- monitorização/controlo
LastModifiedDate datetime2(3) not null constraint [DF_Produto_LastModifiedDate] default getdate(), 
LastModifiedUser varchar(20) not null
)

-- CRIAÇÃO DE TABELA INFOPRODUTO

drop table if exists Produtos.InfoProduto
go 

create table Produtos.InfoProduto(
Id int identity(1,1) not null constraint [PK_InfoProduto_Id] primary key clustered, -- integridade
-- Relacionamento (FK)
ClienteId int not null, 
ProdutoId int not null, 
-- monitorização/controlo
LastModifiedDate datetime2(3) not null constraint [DF_InfoProduto_LastModifiedDate] default getdate(), 
LastModifiedUser varchar(20) not null
)

-- RELACIONAMENTO FK (FK(Coluna caracter não especial) <-> PK)

alter table Produtos.InfoProduto add constraint [FK_InfoProduto_ClienteId] 
foreign key (ClienteId) references Clientes.Cliente(Id)

alter table Produtos.InfoProduto add constraint [FK_InfoProduto_ProdutoId] 
foreign key (ProdutoId) references Produtos.Produto(Id)

--- Visualização de estrura/dados

select * from Clientes.Cliente
select * from Clientes.InfoCliente
select * from Produtos.InfoProduto 
select * from Produtos.Produto

-- Validar esqueleto da tabela

-- SELECCIONAR SCHEMA E TABELA + ALT + F1

---- inserts (DML) - POPULAR

insert into Clientes.Cliente values ('Ana', 'Grade', '02/28/1990',getdate(), 'BD' )
insert into Clientes.Cliente values ('Rui', 'Costa', '12/13/1946',getdate(), 'BD' )
insert into Clientes.Cliente values ('Luis', 'Antunes', '05/11/1956',getdate(), 'BD' )
insert into Clientes.Cliente values ('John', 'Smith', '04/04/2000',getdate(), 'BD' )
insert into Clientes.Cliente values ('Juliana', 'Carvalho', '01/01/1998',getdate(), 'BD' )

insert into Produtos.Produto values ('Arroz', 'Sigala', getdate(), 'BD' )
insert into Produtos.Produto values ('Massa', 'Nacional', getdate(), 'BD' )
insert into Produtos.Produto values ('Batata Doce', null, getdate(), 'BD' )
insert into Produtos.Produto values ('Iogurtes', null, getdate(), 'BD' )

-- FORÇAR ERRO ID
-- insert into Produtos.Produto values (5,'Detergente', 'SKIP', getdate(), 'BD' )


insert into Clientes.InfoCliente values ('1500.00','Rua da Liberdade, nº24', 'Lisboa', '3877-201',1,getdate(), 'BD' )
insert into Clientes.InfoCliente values ('2540.45','Av da Luz, nº220', 'Porto', '4888-001',2,getdate(), 'BD' )
insert into Clientes.InfoCliente values ('535.46','Rua da Costodia, nº01', 'Mafra', '1987-112',3,getdate(), 'BD' )
insert into Clientes.InfoCliente values ('999.99','Travessa da Ribeira', 'Lisboa', '3765-222',4,getdate(), 'BD' )
insert into Clientes.InfoCliente values ('10000','Av da Fronteza', 'Vila Nova De Gaia', '3998-543',5,getdate(), 'BD' )

insert into Produtos.InfoProduto values (1,1,getdate(), 'BD' )
insert into Produtos.InfoProduto values (2,1,getdate(), 'BD' )
insert into Produtos.InfoProduto values (3,2,getdate(), 'BD' )
insert into Produtos.InfoProduto values (4,4,getdate(), 'BD' )
insert into Produtos.InfoProduto values (5,2,getdate(), 'BD' )

-- FORÇAR ERRO FK

insert into Produtos.InfoProduto values (1,5,getdate(), 'BD' )


--- DML (UPDATE/DELETE/TRUNCATE)

-- UPDATE 

update Produtos.Produto
set DescProduto = 'Nacional'
where Id = 3

select * from Produtos.Produto


update Produtos.Produto
set DescProduto = 'Mimosa'
where Id = 4

select * from Produtos.Produto
select * from Produtos.InfoProduto

--- DELETE

--parcial
delete Produtos.InfoProduto
where Id = 4

delete Produtos.Produto
where Id = 4

-- totalidade
delete Produtos.Produto

--- TRUNCATE

-- totalidade
truncate table produtos.produto

-- DDL (ALTER/DROP)

select * from Produtos.Produto 

-- ELIMINAR COLUNA

ALTER TABLE Produtos.Produto DROP COLUMN LastModifiedUser

-- ADICIONAR COLUNA 

ALTER TABLE Produtos.Produto add CartaoCidadao varchar(10) null

update Produtos.Produto
set CartaoCidadao = '12345657'

-- ALTERAR COLUNA EXISTENTE
alter table Produtos.Produto alter column CartaoCidadao varchar(10) not null


