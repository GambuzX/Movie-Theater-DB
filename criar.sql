DROP TABLE IF EXISTS Cinema;
DROP TABLE IF EXISTS Sala;
DROP TABLE IF EXISTS SistemaSom;
DROP TABLE IF EXISTS Ecra;
DROP TABLE IF EXISTS Lugar;
DROP TABLE IF EXISTS LugarOcupado;
DROP TABLE IF EXISTS Filme;
DROP TABLE IF EXISTS Categoria;
DROP TABLE IF EXISTS Critica;
DROP TABLE IF EXISTS FilmeTemCategoria;
DROP TABLE IF EXISTS CinemaTemFilme;
DROP TABLE IF EXISTS Sessao;
DROP TABLE IF EXISTS Bilhete;
DROP TABLE IF EXISTS Pedido;
DROP TABLE IF EXISTS PostoVenda;
DROP TABLE IF EXISTS Produto;
DROP TABLE IF EXISTS ProdutoDisponivel;
DROP TABLE IF EXISTS ProdutoAdquirido;
DROP TABLE IF EXISTS Pessoa;
DROP TABLE IF EXISTS Funcionario;
DROP TABLE IF EXISTS Cliente;
DROP TABLE IF EXISTS Usual;
DROP TABLE IF EXISTS Membro;
DROP TABLE IF EXISTS Cartao;

CREATE TABLE Cinema(
	cinemaID INT PRIMARY KEY,
	nome TEXT,
	telefone INT,
	morada TEXT,
	codigoPostal TEXT,
	email TEXT,
	site TEXT
);

CREATE TABLE Sala(
	salaID INT PRIMARY KEY,
	numero INT,
	cinema INT REFERENCES Cinema,
	numLugares INT,
	sistemaSom INT REFERENCES SistemaSom,
	ecra INT REFERENCES Ecra
);

CREATE TABLE SistemaSom(
	sistemaSomID INT PRIMARY KEY,
	nome TEXT,
	classificacao INT
);

CREATE TABLE Ecra(
	ecraID INT PRIMARY KEY,
	nome TEXT,
	polegadas REAL,
	classificacao INT

);

CREATE TABLE Lugar(
	lugarID INT PRIMARY KEY,
	sala INT REFERENCES Sala,
	fila INT,
	numero INT,
	VIP INT /* 0 ou 1 */
);

CREATE TABLE LugarOcupado(
	sessaoID INT REFERENCES Sessao,
	lugarID INT REFERENCES Lugar,
	ocupado INT, /* 0 ou 1 */
	PRIMARY KEY(sessaoID, lugarID)
);

CREATE TABLE Filme(
	filmeID INT PRIMARY KEY,
	nome TEXT,
	diretor TEXT,
	resumo TEXT;
	duracao INT,
	dataEstreia DATE

);

CREATE TABLE Categoria(
	categoriaID INT PRIMARY KEY,
	nome TEXT,
	descricao TEXT
);

CREATE TABLE Critica(
	criticaID INT PRIMARY KEY,
	autor TEXT,
	filmeID INT REFERENCES Film,
	classificacao INT,
	descricao TEXT
);

CREATE TABLE FilmeTemCategoria(
	filmeID INT REFERENCES Filme,
	categoriaID INT REFERENCES Categoria,
	PRIMARY KEY(filmeID, categoriaID)
);

CREATE TABLE CinemaTemFilme(
	cinemaID INT REFERENCES Cinema,
	filmeID INT REFERENCES Filme,
	PRIMARY KEY(cinemaID, filmeID)
);
