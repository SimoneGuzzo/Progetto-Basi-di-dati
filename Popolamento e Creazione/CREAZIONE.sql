DROP TABLE BUSTA_PAGA;
DROP TABLE DIPENDETE;
DROP TABLE MONTATORE;
DROP TABLE VENDITORE;
DROP TABLE MAGAZZINIERE;
DROP TABLE COMMERCIALISTA;
DROP TABLE PAGAMENTO;
DROP TABLE CLIENTE;
DROP TABLE CONTRATTO;
DROP TABLE CONTRATTO_MOBILE;
DROP TABLE VENDITORE;
DROP TABLE PRESTIGIO;
DROP TABLE MOBILE;
DROP TABLE MAGAZZINO;
DROP TABLE PROMOZIONE;
DROP TABLE CONSEGNA;
DROP TABLE SQUADRA;
DROP TABLE ATTREZZATURA;
DROP TABLE VEICOLO;
DROP TABLE CONSEGNA_MOBILE;
DROP TABLE SQUADRA_VEICOLO
DROP TABLE SQUADRA_ATTREZZATURE;


/* CREAZIONE TABELLA DIPENDENTE */
CREATE TABLE DIPENDENTE (
#TESSERA CHAR(10) PRIMARY KEY,
CF CHAR(16) UNIQUE NOT NULL,
NOME VARCHAR(20) NOT NULL,
COGNOME VARCHAR(20) NOT NULL,
DN DATE,
SESSO CHAR(1) CHECK (SESSO IN('M','F','m','f')),
TEL VARCHAR(12),
VIA VARCHAR(30),
CITTA VARCHAR(20),
CAP CHAR(5),
REGIME ORARIO NUMBER(1,0)
);

/* CREAZIONE TABELLA MONTATORE */
CREATE TABLE MONTATORE (
#TESSERA CHAR(10) PRIMARY KEY,
ADDETTI_A VARCHAR(20),
CONSTRAINT FK_MONTATORE_TESSERA FOREIGN KEY (#TESSERA) REFERENCES DIPENDENTE(#TESSERA)
CONSTRAINT FK_MONTATORE_ID_S FOREIGN KEY (ID_S) REFERENCES SQUADRA(ID_S)
);

/* CREAZIONE TABELLA VENDITORE */
CREATE TABLE VENDITORE (
#TESSERA CHAR(10) PRIMARY KEY,
#UFFICIO NUMBER(1,0),
CONSTRAINT FK_VENDITORE_TESSERA FOREIGN KEY (#TESSERA) REFERENCES DIPENDENTE(#TESSERA)
CONSTRAINT FK_VENDITORE_ID_PRESTIGIO FOREIGN KEY (ID_PRESTIGIO) REFERENCES BONUS(ID_PRESTIGIO)
);

/* CREAZIONE TABELLA MAGAZZINIERE */
CREATE TABLE MAGAZZINIERE (
#TESSERA CHAR(10) PRIMARY KEY,
ADDETTI_A VARCHAR(20),
CONSTRAINT FK_MAGAZZINIERE_TESSERA FOREIGN KEY (#TESSERA) REFERENCES DIPENDENTE(#TESSERA),
CONSTRAINT FK_MAGAZZINIERE_ID_M FOREIGN KEY (ID_M) REFERENCES MAGAZZINO(ID_M)
);

/* CREAZIONE TABELLA BUSTA_PAGA */
CREATE TABLE BUSTA_PAGA (
ID_BP NUMBER(2,0) PRIMARY KEY,
IMPORTO NUMBER(4,0) NOT NULL,
CONSTRAINT FK_BUSTA_PAGA_TESSERA FOREIGN KEY (#TESSERA) REFERENCES DIPENDENTE(#TESSERA)
);

/* CREAZIONE TABELLA PAGAMENTO */
CREATE TABLE PAGAMENTO (
ID_P NUMBER(2,0) PRIMARY KEY,
MODALITA CHAR(1) CHECK (MODALITA IN('C','R','c','r'))NOT NULL,
DATA_P DATE NOT NULL,
CONSTRAINT FK_PAGAMENTO_CF_CL FOREIGN KEY (CF_CL) REFERENCES CLIENTE(CF_CL),
CONSTRAINT FK_PAGAMENTO_ID_CONT FOREIGN KEY (ID_CONT) REFERENCES CONTRATTO(ID_CONT)
);

/* CREAZIONE TABELLA CLIENTE */
CREATE TABLE CLIENTE (
CF_CL CHAR(16) PRIMARY KEY,
NOME_CL VARCHAR(20) NOT NULL,
COGNOME_CL VARCHAR(20) NOT NULL,
VIA VARCHAR(30),
CITTA VARCHAR(20),
CAP CHAR(5),
DN DATE,
TEL VARCHAR(12)
);

/* CREAZIONE TABELLA PRESTIGIO */
CREATE TABLE PRESTIGIO (
ID_PRESTIGIO NUMBER(2,0) PRIMARY KEY,
TIPO_PRESTIGIO CHAR(20),
IMPORTO NUMBER(3,0)
);

/* CREAZIONE TABELLA CONTRATTO */
CREATE TABLE CONTRATTO (
ID_CONT NUMBER(2,0) PRIMARY KEY,
#TESSERA CHAR(10) PRIMARY KEY,
TOTALE_PAGAMENTO NUMBER(5,0),
DATA_CONTRATTO DATE NOT NULL,
CONSTRAINT FK_PAGAMENTO_CF_CL FOREIGN KEY (CF_CL) REFERENCES CLIENTE(CF_CL)
);

/* CREAZIONE TABELLA CONTRATTO_MOBILE */
CREATE TABLE CONTRATTO_MOBILE (
ID_CONT NUMBER(2,0),
COD_BARRA_M CHAR(13),
QUANTITA_AQUISTATA NUMBER(2,0),
CONSTRAINT FK_CONTRATTO_MOBILE_ID_CONT FOREIGN KEY (ID_CONT) REFERENCES CONTRATTO(ID_CONT),
CONSTRAINT FK_CONTRATTO_MOBILE_COD_BARRA_M FOREIGN KEY (COD_BARRA_M) REFERENCES MOBILE(COD_BARRA_M)
);

/* CREAZIONE TABELLA MOBILE */
CREATE TABLE MOBILE (
COD_BARRA_M CHAR(13) PRIMARY KEY,
NOME VARCHAR(20) NOT NULL,
MATERIALE VARCHAR(20),
MARCA VARCHAR(20),
COLORE VARCHAR(20),
PREZZO NUMBER(4,0) NOT NULL,
PREZZO_SCONTATO(4,0),
LUNGHEZZA NUMBER(4,2),
ALTEZZA NUMBER(4,2),
CONSTRAINT FK_MOBILE_P_IVA FOREIGN KEY (P_IVA) REFERENCES FORNITORE_MOBILE(P_IVA),
QUANTITA_M NUMBER(2,0);
CONSTRAINT FK_MOBILE_ID_M FOREIGN KEY (ID_M) REFERENCES MAGAZZINO(ID_M),
CONSTRAINT FK_MOBILE_ID_PROMO FOREIGN KEY (ID_PROMO) REFERENCES PROMOZIONE(ID_PROMO),
DATA_INIZIO DATE NOT NULL,
DATA_FINE DATE NOT NULL
);

/* CREAZIONE TABELLA MAGAZZINO */
CREATE TABLE MAGAZZINO (
ID_M NUMBER(2,0) PRIMARY KEY,
NOME_REPARTO VARCHAR(20) NOT NULL,
VIA VARCHAR(30),
CITTA VARCHAR(20),
CAP CHAR(5),
);

/* CREAZIONE TABELLA PROMOZIONE */
CREATE TABLE PROMOZIONE (
ID_PROMO NUMBER(2,0) PRIMARY KEY,
SCONTO NUMBER(2,0)
);

/* CREAZIONE TABELLA CONSEGNA */
CREATE TABLE CONSEGNA (
ID_CONS NUMBER(2,0) PRIMARY KEY,
DATA_CONSEGNA DATE NOT NULL,
VIA VARCHAR(30),
N_CIV NUMBER (2,0),
CITTA VARCHAR(20),
CAP CHAR(5),
CONSTRAINT FK_CONSEGNA_ID_S FOREIGN KEY (ID_S) REFERENCES SQUADRA(ID_S)
);

/* CREAZIONE TABELLA CONSEGNA_MOBILE */
CREATE TABLE CONSEGNA_MOBILE (
ID_CONS NUMBER(2,0),
COD_BARRA_M CHAR(13),
CONSTRAINT FK_CONSEGNA_MOBILE_ID_CONS FOREIGN KEY (ID_CONS) REFERENCES CONSEGNA(ID_CONS),
CONSTRAINT FK_CONSEGNA_MOBILE_COD_BARRA_M FOREIGN KEY (COD_BARRA_M) REFERENCES MOBILE(COD_BARRA_M)
);

/* CREAZIONE TABELLA SQUADRA */
CREATE TABLE SQUADRA (
ID_S NUMBER(2,0) PRIMARY KEY,
#MEMBRI NUMBER(2,0)
);

/* CREAZIONE TABELLA SQUADRA_VEICOLO */
CREATE TABLE SQUADRA_VEICOLO (
ID_S NUMBER(2,0),
TARGA CHAR(7),
CONSTRAINT FK_SQUADRA_VEICOLO_ID_S FOREIGN KEY (ID_S) REFERENCES SQUADRA(ID_S),
CONSTRAINT FK_SQUADRA_VEICOLO_TARGA FOREIGN KEY (TARGA) REFERENCES VEICOLO(TARGA)
);


/* CREAZIONE TABELLA VEICOLO */
CREATE TABLE VEICOLO (
TARGA CHAR(7) PRIMARY KEY,
MODELLO_V VARCHAR(20) NOT NULL,
MARCA_V VARCHAR(20) NOT NULL,
CILINDRATA NUMBER(4,0)
);

/* CREAZIONE TABELLA ATTREZZATURA */
CREATE TABLE ATTREZZATURA (
COD_BARRA_A CHAR(7) PRIMARY KEY,
NOME_A VARCHAR(20) NOT NULL,
MODELLO_A VARCHAR(20) NOT NULL,
MARCA_A VARCHAR(20) NOT NULL,
QUANTITA NUMBER(2,0),
CONSTRAINT FK_ATTREZZATURA_P_IVA FOREIGN KEY (P_IVA) REFERENCES FORNITORE_ATTREZZATURA(P_IVA)
);

/* CREAZIONE TABELLA SQUADRA_ATTREZZATURE*/  
CREATE TABLE SQUADRA_ATTREZZATURE (
ID_S NUMBER(2,0),
COD_BARRA_A CHAR(7),
CONSTRAINT FK_SQUADRA_ATTREZZATURE_ID_S FOREIGN KEY (ID_S) REFERENCES SQUADRA(ID_S),
CONSTRAINT FK_SQUADRA_ATTREZZATURE_COD_BARRA_A FOREIGN KEY (COD_BARRA_A) REFERENCES ATTREZZATURA(COD_BARRA_A)
);

/* CREAZIONE TABELLA FORNITORE_ATTREZZATURA */
CREATE TABLE FORNITORE_ATTREZZATURA (
P_IVA CHAR(7) PRIMARY KEY,
NOME_F VARCHAR(20) NOT NULL,
VIA VARCHAR(30),
CITTA VARCHAR(20),
CAP CHAR(5),
TIPO_FORN_A VARCHAR(20)
);

/* CREAZIONE TABELLA FORNITORE_MOBILE */
CREATE TABLE FORNITORE_MOBILE (
P_IVA CHAR(7) PRIMARY KEY,
NOME_F VARCHAR(20) NOT NULL,
VIA VARCHAR(30),
CITTA VARCHAR(20),
CAP CHAR(5),
TIPO_FORN_M VARCHAR(20)
);
