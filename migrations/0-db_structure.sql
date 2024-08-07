CREATE TABLE base (
	"ID EQP" int NOT NULL,
	"DATA HORA" timestamp NOT NULL,
	"MILESEGUNDO" int NOT NULL,
	"FAIXA" int NOT NULL,
	"ID DE ENDEREÇO" int NOT NULL,
	"VELOCIDADE DA VIA" decimal NOT NULL,
	"VELOCIDADE AFERIDA" decimal NOT NULL,
	"CLASSIFICAÇÃO" varchar(50) NOT NULL,
	"TAMANHO" decimal NOT NULL,
	"NUMERO DE SÉRIE" int NOT NULL,
	"LATITUDE" decimal NOT NULL,
	"LONGITUDE" decimal NOT NULL,
	"ENDEREÇO" varchar(255) NOT NULL,
	"SENTIDO" varchar(255) NOT NULL
);

CREATE TABLE radares (
	id_eqp int NOT NULL,
	velocidade_permitida int NOT NULL,
	numero_serie int NOT NULL,
	latitude decimal NOT NULL,
	longitude decimal NOT NULL,
	endereco varchar(255) NOT NULL,
	sentido varchar(255) NOT NULL,

	CONSTRAINT radares_pk PRIMARY KEY (id_eqp)
);

CREATE TABLE leituras (
	id serial PRIMARY KEY,
	horario timestamp NOT NULL,
	faixa int NOT NULL,
	velocidade_aferida decimal NOT NULL,
	classificacao varchar(50) NOT NULL,
	tamanho decimal NOT NULL,
	radar_id int4 NOT NULL,
  
	CONSTRAINT leituras_fk FOREIGN KEY (radar_id) REFERENCES radares(id_eqp) ON DELETE CASCADE
);

