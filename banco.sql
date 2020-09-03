create db_nomedobanco;

use db_nomedobanco; 


create table tb_cliente(
	cpf char(14),
	nome varchar(150) not null,
	sobrenome varchar(150) not null,
	rg char(12),
	uf_rg char(2),
	logradouro varchar(150),
	numero int,
	complemento varchar(100),
	cidade varchar(150),
	estado char(2),

	constraint pk_cpf_cliente primary key(cpf),
	constraint uk_rg_cliente unique(rg, uf_rg),
);

alter table tb_cliente add
constraint ck_compl_end default ('nao informado') for complemento


create table tb_FUNCIONARIO(
	matricula int identity,
	nome varchar(150) not null,
	rg char(12) not null,
	uf_rg char(2) not null,
	cpf char(14) not null,

	constraint pk_matricula_funcionario primary key(matricula),
	constraint uk_rg_funcionario unique(rg, uf_rg),
	constraint uk_cpf_funcionario unique(cpf)

);

create table tb_VAGA(
	numero int,
	setor varchar(100),

	constraint pk_numero_vaga primary key(numero)

);
create table tb_VEICULO(
	placa varchar(20),
	cpf_cliente char(14),
	marca varchar(100),
	cor varchar(50),
	modelo varchar(100),
	matricula_func_cadastro int not null,

	constraint pk_placa_veiculo primary key(placa, cpf_cliente),
	constraint fk_cpf_cleinte foreign key (cpf_cliente) references tb_cliente(cpf),
	constraint fkmatric_func_cad foreign key (matricula_func_cadastro) references tb_funcionario(matricula),

);

create table tb_LOCACAO(
	placa_veiculo varchar(20),
	cpf_cliente char(14),
	numero_vaga int,
	data_hora_entrada datetime,
	data_hora_saida datetime,
	valor money,

	constraint pk_placa_vaga_loc primary key (placa_veiculo,numero_vaga),
	constraint fk_placa_cpf_cli foreign key (placa_veiculo, cpf_cliente) references tb_veiculo (placa,cpf_cliente),
	constraint fk_num_vaga_loc foreign key (numero_vaga) references tb_vaga (numero),
	constraint ck_valor check (valor >= 10.99),
	
);
alter table tb_locacao add
constraint df_data_entrada default (GETDATE()) for data_hora_entrada