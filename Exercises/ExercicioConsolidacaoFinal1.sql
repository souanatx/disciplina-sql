-- Exercício de consolidação feito por Ana Teixeira: 

CREATE DATABASE INTERGALATICOS
GO

CREATE SCHEMA Jogadores authorization [dbo]
go

CREATE SCHEMA Equipas authorization [dbo]
go

drop table if exists Jogadores.Jogador
go 

create table Jogadores.Jogador(
Id int identity(1,1) not null constraint [PK_Jogador_Id] primary key clustered,
NomeJogador varchar(50) not null,  
NumeroCamisola int not null, 
DtNascimento date null,
AlteraçãoData datetime2(3) not null constraint [DF_Jogador_AlteraçãoData] default getdate(),
)

drop table if exists Equipas.Equipa
go

create table Equipas.Equipa(
Id int identity(1,1) not null constraint [PK_Equipa_Id] primary key clustered, 
JogadorId int not null,
Equipa varchar(50) not null,
Cidade varchar(50) not null,
Descrição varchar(50) not null,
AlteraçãoData datetime2(3) not null constraint [DF_Equipa_AlteraçãoData] default getdate(),
)

alter table Equipas.Equipa add constraint [FK_Equipa_JogadorId] 
foreign key (JogadorId) references Jogadores.Jogador(Id)

drop table if exists Equipas.InformacoesAdicionais
go

create table Equipas.InformacoesAdicionais(
Id int identity(1,1) not null constraint [PK_InformacoesAdicionais_Id] primary key clustered, 
JogadorId int not null,
Salario decimal(10,2) not null, 
AlteraçãoData datetime2(3) not null constraint [DF_InformacoesAdicionais_AlteraçãoData] default getdate(),
)

alter table Equipas.InformacoesAdicionais add constraint [FK_InformacoesAdicionais_ClienteId] 
foreign key (JogadorId) references Jogadores.Jogador(Id)

insert into Jogadores.Jogador (NomeJogador, NumeroCamisola, DtNascimento, AlteraçãoData) values ('Messi', '10', '06/24/1987', getdate())
insert into Jogadores.Jogador (NomeJogador, NumeroCamisola, DtNascimento, AlteraçãoData) values ('Ronaldo', '7', '02/05/1985', getdate())
insert into Jogadores.Jogador (NomeJogador, NumeroCamisola, DtNascimento, AlteraçãoData) values ('Pizzi', '21', '10/06/1956', getdate())
insert into Jogadores.Jogador (NomeJogador, NumeroCamisola, DtNascimento, AlteraçãoData) values ('Maradona', '10', '10/30/1960', getdate())
insert into Jogadores.Jogador (NomeJogador, NumeroCamisola, DtNascimento, AlteraçãoData) values ('Futre', '12', '02/28/1966', getdate())

insert into Equipas.Equipa (JogadorId, Equipa, Cidade, Descrição, AlteraçãoData) values ('1', 'Barcelona', 'Barcelona', '"', getdate())
insert into Equipas.Equipa (JogadorId, Equipa, Cidade, Descrição, AlteraçãoData) values ('2', 'Juventus', 'Turim', 'Capitao', getdate())
insert into Equipas.Equipa (JogadorId, Equipa, Cidade, Descrição, AlteraçãoData) values ('3', 'Benfica', 'Lisboa', 'Capitao', getdate())
insert into Equipas.Equipa (JogadorId, Equipa, Cidade, Descrição, AlteraçãoData) values ('4', 'Napoli', 'Napoles', '"', getdate())
insert into Equipas.Equipa (JogadorId, Equipa, Cidade, Descrição, AlteraçãoData) values ('5', 'Atlético Madrid', 'Madrid', '"', getdate())

insert into Equipas.InformacoesAdicionais (JogadorId, Salario, AlteraçãoData) values ('1', '1000000', getdate())
insert into Equipas.InformacoesAdicionais (JogadorId, Salario, AlteraçãoData) values ('2', '2000000', getdate())
insert into Equipas.InformacoesAdicionais (JogadorId, Salario, AlteraçãoData) values ('3', '110000', getdate())
insert into Equipas.InformacoesAdicionais (JogadorId, Salario, AlteraçãoData) values ('4', '230000', getdate())
insert into Equipas.InformacoesAdicionais (JogadorId, Salario, AlteraçãoData) values ('5', '1200000', getdate())

-- Para ver:
select * from Jogadores.Jogador
select * from Equipas.Equipa
select * from Equipas.InformacoesAdicionais