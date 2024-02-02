DROP TABLE IF EXISTS utilizador_perfil CASCADE;
DROP TABLE IF EXISTS utilizador CASCADE;
DROP TABLE IF EXISTS tipo_equipamento CASCADE;
DROP TABLE IF EXISTS equipamento CASCADE;
DROP TABLE IF EXISTS tipo_componente CASCADE;
DROP TABLE IF EXISTS armazem CASCADE;
DROP TABLE IF EXISTS componente CASCADE;
DROP TABLE IF EXISTS detalhe_ficha_producao CASCADE;
DROP TABLE IF EXISTS tipo_mao_obra CASCADE;
DROP TABLE IF EXISTS ficha_producao CASCADE;
DROP TABLE IF EXISTS estado_encomenda CASCADE;
DROP TABLE IF EXISTS cliente CASCADE;
DROP TABLE IF EXISTS encomenda_cliente CASCADE;
DROP TABLE IF EXISTS detalhe_encomenda_cliente CASCADE;
DROP TABLE IF EXISTS detalhe_remessa_cliente CASCADE;
DROP TABLE IF EXISTS fatura_cliente CASCADE;
DROP TABLE IF EXISTS guia_remessa_cliente CASCADE;
DROP TABLE IF EXISTS fatura_fornecedor CASCADE;
DROP TABLE IF EXISTS fornecedor CASCADE;
DROP TABLE IF EXISTS encomenda_fornecedor CASCADE;
DROP TABLE IF EXISTS detalhe_encomenda_fornecedor CASCADE;
DROP TABLE IF EXISTS detalhe_remessa_fornecedor CASCADE;
DROP TABLE IF EXISTS guia_remessa_fornecedor CASCADE;



CREATE TABLE utilizador_perfil(
	id											SERIAL				NOT NULL,
	data_criacao								TIMESTAMP			NOT NULL	DEFAULT NOW(),

	perfil										VARCHAR(100)		NOT NULL,
	
	CONSTRAINT pk_utilizador_perfil PRIMARY KEY (id)
);

CREATE TABLE utilizador(
	id											SERIAL				NOT NULL,
	data_criacao								TIMESTAMP			NOT NULL	DEFAULT NOW(),

	email										VARCHAR(500)		NOT NULL,
	senha										VARCHAR(400)		NOT NULL,
	nome										VARCHAR(300)		NOT NULL,
	sobrenome									VARCHAR(300)		NOT NULL,

	perfil_id									INT					NOT NULL,
	
	CONSTRAINT pk_utilizador PRIMARY KEY (id),
	CONSTRAINT fk_perfil__utilizador FOREIGN KEY (perfil_id) REFERENCES utilizador_perfil (id)
);

CREATE TABLE tipo_equipamento(
	id											SERIAL				NOT NULL,
	data_criacao								TIMESTAMP			NOT NULL	DEFAULT NOW(),
	
	tipo										VARCHAR(150)		NOT NULL,

	CONSTRAINT pk_tipo_equipamento PRIMARY KEY (id)
);

CREATE TABLE equipamento(
	id											SERIAL				NOT NULL,
	data_criacao								TIMESTAMP			NOT NULL	DEFAULT NOW(),

	quantidade									INT,
	tipo_id										INT					NOT NULL,

	CONSTRAINT pk_equipamento PRIMARY KEY (id),
	CONSTRAINT fk_tipo__equipamento FOREIGN KEY (tipo_id) REFERENCES tipo_equipamento (id)
);

CREATE TABLE tipo_componente(
	id											SERIAL				NOT NULL,
	data_criacao								TIMESTAMP			NOT NULL	DEFAULT NOW(),

	tipo										VARCHAR(100),
	
	CONSTRAINT pk_tipo_componente PRIMARY KEY (id)
);

CREATE TABLE armazem(
	id											SERIAL				NOT NULL,
	data_criacao								TIMESTAMP			NOT NULL	DEFAULT NOW(),

	endereco									VARCHAR(100),
	
	CONSTRAINT pk_armazem PRIMARY KEY (id)
);

CREATE TABLE componente(
	id											SERIAL				NOT NULL,
	data_criacao								TIMESTAMP			NOT NULL	DEFAULT NOW(),

	descricao									TEXT				NOT NULL,
	quantidade									INT					NOT NULL	DEFAULT (0),

	tipo_id										INT					NOT NULL,
	armazem_id									INT					NOT NULL,
	
	CONSTRAINT pk_componente PRIMARY KEY (id),
	CONSTRAINT fk_tipo__componente FOREIGN KEY (tipo_id) REFERENCES tipo_componente (id),
	CONSTRAINT fk_armazem__componente FOREIGN KEY (armazem_id) REFERENCES armazem (id)
);

CREATE TABLE tipo_mao_obra(
	id											SERIAL				NOT NULL,
	data_criacao								TIMESTAMP			NOT NULL	DEFAULT NOW(),

	tipo										VARCHAR(100),
	custo										MONEY,

	CONSTRAINT pk_tipo_mao_obra PRIMARY KEY (id)
);

CREATE TABLE ficha_producao(
	id											SERIAL				NOT NULL,
	data_criacao								TIMESTAMP			NOT NULL	DEFAULT NOW(),

	quantidade_equipamentos						INT					NOT NULL,
	descricao									TEXT,
	horas										INT					NOT NULL	DEFAULT (0),

	utilizador_id								INT					NOT NULL,
	tipo_mao_obra_id							INT					NOT NULL,
	equipamento_id								INT					NOT NULL,

	CONSTRAINT pk_ficha_producao PRIMARY KEY (id),
	CONSTRAINT fk_utilizador__ficha_producao FOREIGN KEY (utilizador_id) REFERENCES utilizador (id),
	CONSTRAINT fk_tipo_mao_obra__ficha_producao FOREIGN KEY (tipo_mao_obra_id) REFERENCES tipo_mao_obra (id),
	CONSTRAINT fk_equipamento__ficha_producao FOREIGN KEY (equipamento_id) REFERENCES equipamento (id)
);

CREATE TABLE detalhe_ficha_producao(
	id											SERIAL				NOT NULL,
	data_criacao								TIMESTAMP			NOT NULL	DEFAULT NOW(),

	quantidade									INT					NOT NULL	DEFAULT (1),
	
	componente_id								INT					NOT NULL,
	ficha_producao_id							INT					NOT NULL,
	
	CONSTRAINT pk_detalhe_ficha_producao PRIMARY KEY (id),
	CONSTRAINT fk_componente__detalhe_ficha_producao FOREIGN KEY (componente_id) REFERENCES componente (id),
	CONSTRAINT fk_ficha_producao__detalhe_ficha_producao FOREIGN KEY (ficha_producao_id) REFERENCES ficha_producao (id)
);

CREATE TABLE estado_encomenda(
	id											SERIAL				NOT NULL,
	data_criacao								TIMESTAMP			NOT NULL	DEFAULT NOW(),

	estado										VARCHAR(100)		NOT NULL,
	
	CONSTRAINT pk_estado_encomenda PRIMARY KEY (id)
);

CREATE TABLE cliente(
	id											SERIAL				NOT NULL,
	data_criacao								TIMESTAMP			NOT NULL	DEFAULT NOW(),

	email										VARCHAR(500)		NOT NULL,
	senha										VARCHAR(400)		NOT NULL,
	nome										VARCHAR(300)		NOT NULL,
	nif											CHAR(9),

	CONSTRAINT pk_cliente PRIMARY KEY (id)
);

CREATE TABLE fatura_cliente(
	id											SERIAL				NOT NULL,
	data_criacao								TIMESTAMP			NOT NULL	DEFAULT NOW(),

	descricao									TEXT				NOT NULL,
	
	CONSTRAINT pk_fatura_cliente PRIMARY KEY (id)
);

CREATE TABLE encomenda_cliente(
	id											SERIAL				NOT NULL,
	data_criacao								TIMESTAMP			NOT NULL	DEFAULT NOW(),

	estado_id									INT					NOT NULL,
	cliente_id									INT					NOT NULL,

	CONSTRAINT pk_encomenda_cliente PRIMARY KEY (id),
	CONSTRAINT fk_estado__encomenda_cliente FOREIGN KEY (estado_id) REFERENCES estado_encomenda (id),
	CONSTRAINT fk_cliente__encomenda_cliente FOREIGN KEY (cliente_id) REFERENCES cliente (id)
);

CREATE TABLE detalhe_encomenda_cliente(
	id											SERIAL				NOT NULL,
	data_criacao								TIMESTAMP			NOT NULL	DEFAULT NOW(),

	quantidade									INT					NOT NULL	DEFAULT (0),
	custo_unidade								MONEY				NOT NULL,

	equipamento_id								INT					NOT NULL,
	encomenda_id								INT					NOT NULL,
	
	CONSTRAINT pk_detalhe_encomenda_cliente PRIMARY KEY (id),
	CONSTRAINT fk_equipamento__detalhe_encomenda_cliente FOREIGN KEY (equipamento_id) REFERENCES equipamento (id),
	CONSTRAINT fk_encomenda__detalhe_encomenda_cliente FOREIGN KEY (encomenda_id) REFERENCES encomenda_cliente (id)
);

CREATE TABLE guia_remessa_cliente(
	id											SERIAL				NOT NULL,
	data_criacao								TIMESTAMP			NOT NULL	DEFAULT NOW(),

	data_envio									TIMESTAMP			NOT NULL,
	data_entrega								TIMESTAMP,
	endereco_origem								VARCHAR(300)		NOT NULL,
	endereco_chegada							VARCHAR(300)		NOT NULL,

	detalhe_encomenda_id						INT					NOT NULL,
	utilizador_id								INT					NOT NULL,
	fatura_id									INT					NOT NULL,

	CONSTRAINT pk_guia_remessa_cliente PRIMARY KEY (id),
	CONSTRAINT fk_detalhe_encomenda__guia_remessa_cliente FOREIGN KEY (detalhe_encomenda_id) REFERENCES detalhe_encomenda_cliente (id),
	CONSTRAINT fk_utilizador__guia_remessa_cliente FOREIGN KEY (utilizador_id) REFERENCES utilizador (id),
	CONSTRAINT fk_fatura__guia_remessa_cliente FOREIGN KEY (fatura_id) REFERENCES fatura_cliente (id)
);

CREATE TABLE detalhe_remessa_cliente(
	id											SERIAL				NOT NULL,
	data_criacao								TIMESTAMP			NOT NULL	DEFAULT NOW(),

	quantidade									INT					NOT NULL	DEFAULT (0),

	detalhe_encomenda_id						INT					NOT NULL,
	remessa_id									INT					NOT NULL,
	
	CONSTRAINT pk_detalhe_remessa_cliente PRIMARY KEY (id),
	CONSTRAINT fk_detalhe_encomenda__detalhe_remessa_cliente FOREIGN KEY (detalhe_encomenda_id) REFERENCES detalhe_encomenda_cliente (id),
	CONSTRAINT fk_remessa__detalhe_remessa_cliente FOREIGN KEY (remessa_id) REFERENCES guia_remessa_cliente (id)
);

CREATE TABLE fatura_fornecedor(
	id											SERIAL				NOT NULL,
	data_criacao								TIMESTAMP			NOT NULL	DEFAULT NOW(),

	descricao									TEXT				NOT NULL,
	
	CONSTRAINT pk_fatura_fornecedor PRIMARY KEY (id)
);


CREATE TABLE fornecedor(
	id											SERIAL				NOT NULL,
	data_criacao								TIMESTAMP			NOT NULL	DEFAULT NOW(),

	nome										VARCHAR(100)		NOT NULL,
	nif											CHAR(9)				NOT NULL,
	email										VARCHAR(200),
	telefone									CHAR(9),
	endereco									VARCHAR(500)		NOT NULL,
	
	CONSTRAINT pk_fornecedor PRIMARY KEY (id)
);

CREATE TABLE encomenda_fornecedor(
	id											SERIAL				NOT NULL,
	data_criacao								TIMESTAMP			NOT NULL	DEFAULT NOW(),

	estado_id									INT					NOT NULL,
	fornecedor_id								INT					NOT NULL,

	CONSTRAINT pk_encomenda_fornecedor PRIMARY KEY (id),
	CONSTRAINT fk_estado__encomenda_fornecedor FOREIGN KEY (estado_id) REFERENCES estado_encomenda (id),
	CONSTRAINT fk_fornecedor__encomenda_fornecedor FOREIGN KEY (fornecedor_id) REFERENCES fornecedor (id)
);

CREATE TABLE detalhe_encomenda_fornecedor(
	id											SERIAL				NOT NULL,
	data_criacao								TIMESTAMP			NOT NULL	DEFAULT NOW(),

	quantidade									INT					NOT NULL	DEFAULT (0),
	custo_entidade								MONEY				NOT NULL,

	componente_id								INT					NOT NULL,
	encomenda_id								INT					NOT NULL,
	
	CONSTRAINT pk_detalhe_encomenda_fornecedor PRIMARY KEY (id),
	CONSTRAINT fk_componente__detalhe_encomenda_fornecedor FOREIGN KEY (componente_id) REFERENCES componente (id),
	CONSTRAINT fk_encomenda__detalhe_encomenda_fornecedor FOREIGN KEY (encomenda_id) REFERENCES encomenda_fornecedor (id)
);

CREATE TABLE guia_remessa_fornecedor(
	id											SERIAL				NOT NULL,
	data_criacao								TIMESTAMP			NOT NULL	DEFAULT NOW(),

	data_envio									TIMESTAMP			NOT NULL,
	data_entrega								TIMESTAMP,
	endereco_origem								VARCHAR(300)		NOT NULL,
	endereco_chegada							VARCHAR(300)		NOT NULL,

	detalhe_encomenda_id						INT					NOT NULL,
	utilizador_id								INT					NOT NULL,
	fatura_id									INT					NOT NULL,

	CONSTRAINT pk_guia_remessa_fornecedor PRIMARY KEY (id),
	CONSTRAINT fk_detalhe_encomenda__guia_remessa_fornecedor FOREIGN KEY (detalhe_encomenda_id) REFERENCES detalhe_encomenda_fornecedor (id),
	CONSTRAINT fk_utilizador__guia_remessa_fornecedor FOREIGN KEY (utilizador_id) REFERENCES utilizador (id),
	CONSTRAINT fk_fatura__encomenda_cliente FOREIGN KEY (fatura_id) REFERENCES fatura_cliente (id)
);

CREATE TABLE detalhe_remessa_fornecedor(
	id											SERIAL				NOT NULL,
	data_criacao								TIMESTAMP			NOT NULL	DEFAULT NOW(),

	quantidade									INT					NOT NULL	DEFAULT (0),

	detalhe_encomenda_id						INT					NOT NULL,
	remessa_id									INT					NOT NULL,
	
	CONSTRAINT pk_detalhe_remessa_fornecedor PRIMARY KEY (id),
	CONSTRAINT fk_detalhe_encomenda__detalhe_remessa_fornecedor FOREIGN KEY (detalhe_encomenda_id) REFERENCES detalhe_encomenda_fornecedor (id),
	CONSTRAINT fk_remessa__detalhe_remessa_fornecedor FOREIGN KEY (remessa_id) REFERENCES guia_remessa_fornecedor (id)
);