/*
Hierarquia de objetos SQL SSMS:
INSTANCIA -- BASE DADOS -- OBJETOS -- DADOS

CONJUNTOS DE QUERYS:
.DML - DATA MANIPULATION LANGUAGE - COMANDOS DE INSERT, UPDATE, DELETE E TRUNCATE
.DDL - DATA DEFINITION LANGUAGE - COMANDOS CREATE, ALTER E DROP
.DQL - DATA QUERY LANGUAGE - SELECT

go serve como espécie de separador
*/

-- CRIAÇÃO DE BASE DADOS

CREATE DATABASE STORE
GO


-- USO DE BASE DADOS

use STORE
go 

-- CRIAÇÃO DE SCHEMAS
-- Schema é utilizado para organizar visualmente a base de dados. É a primeira parte do nome. A outra é a tabela (que é criada dentro do schema).

CREATE SCHEMA Clientes authorization [dbo]
go
CREATE SCHEMA Produtos authorization [dbo]
go

-- CRIAÇÃO DE MODELO DE DADOS 
-- nomeadamente CRIAÇÃO DE TABELAS E RELACIONAMENTOS
-- CRIAÇÃO DE TABELA CLIENTES - é a tabela que tem a info geral

drop table if exists Clientes.Cliente
go
-- este comando serve para eliminar... coloca-se antes da tabela. a nivel académico não se usa, só a nivel de trabalho

create table Clientes.Cliente(
Id int identity(1,1) not null constraint [PK_Cliente_Id] primary key clustered, -- pk é o que revela a integridade de uma tabela
-- ditam as boas práticas que se coloca sempre id como chave primária. (1,1) são propriedades e a primeira propriedade identifica a posição onde deve começar. 
-- as tabelas podem ser construidas sem indice (tabela pobre) ou com indice. existem muitos tipos de indices. há 2 principais: clustered (sempre colocado sobre uma chave primária) e nonclustered (sempre colocado em colunas de caráter nao especial, colunas que têm apenas regras de negócio)
-- depois da constraint aparece uma etiqueta que corresponde aos parenteses retos
-- vamos agora inserir as regras de negócio:
Pnome varchar(20) not null,
Unome varchar(20) not null,
Dtnasc date not null, -- dd/mm/aa
-- colunas de monitorização (controlar os inserts e alterações que possam ser feitas ao nível da nossa tabela):
LastModifiedDate datetime2(3) not null constraint [DF_Cliente_LastModifiedDate] default getdate(), 
-- o 3 equivale à precisão dos milésimos de segundo, default singifica que a constraint é por valor padrão
LastModifiedUser varchar(20) not null 
)

-- CRIAÇÃO DE TABELA INFOCLIENTES
drop table if exists Clientes.InfoCliente
go

create table Clientes.InfocLIENTE(
Id int identity(1,1) not null constraint [PK_InfoCliente_Id] primary key clustered, -- integridade
-- regras de negócio:
Salario decimal(10,4) null, -- EXEMPLO: 11111,1111
Morada varchar(50) not null,
Localidade varchar (50) not null,
CodPostal varchar (10) not null,
--Relacionamento(FK)
ClienteId int not null,
--Monitorização/controlo
LastModifiedDate datetime2(3) not null constraint [DF_InfoCliente_LastModifiedDate] default getdate(),
LastModifiedUser varchar(20) not null
)

-- RELACIONAMENTO FK (FK(Coluna carater não especial) relaciona-se com PK)
alter table Clientes.InfoCliente add constraint [FK_InfoCLiente_ClienteId]
foreign key (ClienteId) references Clientes.Cliente(Id)


-- CRIAÇÃO DE TABELA PRODUTO
drop table if exists Produtos.Produto
go

create table Produtos.Produto(
Id int identity(1,1) not null constraint [PK_Produto_Id] primary key clustered, -- integridade
--regras de negocio
Nome varchar (20) not null,
DescProduto varchar (20) null,
--monitorização
LastModifiedDate datetime2(3) not null constraint [DF_Produto_LastModifiedDate] default getdate(),
LastModifiedUser varchar (20) not null
)

-- CRIAÇÃO DE TABELA INFOPRODUTO
drop table if exists Produtos.InfoProduto
go

create table Produtos.InfoProduto(
Id int identity(1,1) not null constraint [PK_InfoProduto_Id] primary key clustered, -- integridade
--relacionamento (FK)
ClienteId int not null,
ProdutoId int null,
--monitorização
LastModifiedDate datetime2(3) not null constraint [DF_InfoProduto_LastModifiedDate] default getdate(),
LastModifiedUser varchar (20) not null
)

-- RELACIONAMENTO FK (FK(Coluna caracter não especial) <--> PK)
alter table Produtos.InfoProduto add constraint [FK_InfoProduto_ClienteId]
foreign key (ClienteId) references Clientes.Cliente(Id)

alter table Produtos.InfoProduto add constraint [FK_InfoProduto_ProdutoId]
foreign key (ProdutoId) references Produtos.Produto(Id)

-- Visualização de estrutura/dados
select * from Clientes.Cliente
select * from Clientes.InfoCliente
select * from Produtos.InfoProduto
select * from Produtos.Produto

-- Validar esqueleto da tabela

-- Selecionar schema e tabela + ALT + F1

-- insert (faz parte da DML) -- estamos a POPULAR a tabela
insert into Clientes.Cliente values ('Ana', 'Teixeira', '08/05/1997', getdate(), 'BD')
insert into Clientes.Cliente values ('Ana', 'Costa', '12/01/1990', getdate(), 'BD')

insert into Produtos.Produto values ('Arroz', 'Sigala', getdate(), 'BD')
insert into Produtos.Produto values ('Massa', 'Nacional', getdate(), 'BD')

-- FORÇAR ERRO ID
/*set identity_insert on
insert into Produtos.Produto values (5, 'Detergente', 'SKIP', getdate(), 'BD')
set identity_insert off
*/

insert into Clientes.InfoCliente values ( '1500.00', 'Rua da Liberdade nº 24', 'Lisboa', '3877-201',1, getdate(), 'BD')
insert into Clientes.InfoCliente values ( '2540.45', 'Rua Camões nº 24', 'Porto', '4877-301', 1, getdate(), 'BD')

insert into Produtos.InfoProduto values (1,1,getdate(), 'BD')
insert into Produtos.InfoProduto values (2,1,getdate(), 'BD')

-- DML (UPDATE/DELETE/TRUNCATE)
update Produtos.Produto
set DescProduto = 'hmm'
where Id = 1

select * from Produtos.Produto

-- DELETE (permite remover por linha a linha ou todos os dados da tabela)
begin transaction 

delete Produtos.Produto
where Id = 1

rollback

-- DELETE totalidade 
begin transaction 

delete Produtos.Produto

rollback


-- TRUNCATE (permite remover todos os dados da tabela)

truncate table Produtos.Produto -- normal dar erro porque teria de tirar a restrição


-- DDL (ALTER/DROP)

select * from Produtos.Produto

-- ELIMINAR COLUNA

ALTER TABLE Produtos.Produto DROP COLUMN LastModifiedUser

-- ADICIONAR COLUNA

ALTER TABLE Produtos.Produto add CartaoCidadao varchar (10) null
-- com "not null" não deixa pois para colocar uma coluna como not null para ser inserida vem como null obrigatoriamente

update Produtos.Produto
set CartaoCidadao = '123456789'

-- ALTERAR COLUNA EXISTENTE
alter table Produtos.Produto alter column CartaoCidadao varchar (10) not null

