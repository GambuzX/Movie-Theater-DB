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


CREATE TABLE Sessao(
	sessaoID INT PRIMARY KEY,
	horaInicio TEXT,
	lugaresDisponiveis INT,
	salaID INT REFERENCES Sala,
	filmeID INT REFERENCES Filme
);

CREATE TABLE Bilhete(
	bilheteID INT PRIMARY KEY,
	dataCompra DATE,
	sessaoID INT REFERENCES Sessao,
	lugarID INT REFERENCES Lugar,
	pedidoID INT REFERENCES Pedido
);

CREATE TABLE Pedido(
	pedidoID INT PRIMARY KEY,
	precoOriginal REAL,
	precoEfetivo REAL,
	dataPagamento DATE,
	postoVendaID INT REFERENCES PostoVenda,
	funcionarioID INT REFERENCES Funcionario,
	clienteID INT REFERENCES Cliente
);

CREATE TABLE PostoVenda(
	postoVendaID INT PRIMARY KEY,
	numero INT,
	cinemaID INT REFERENCES Cinema
);

CREATE TABLE Produto(
	produtoID INT PRIMARY KEY,
	nome TEXT,
	preco REAL
);

CREATE TABLE ProdutoDisponivel(
	produtoID INT REFERENCES Produto,
	postoVendaID INT REFERENCES PostoVenda,
	stock INT,
	PRIMARY KEY(produtoID, postoVendaID)
);

CREATE TABLE ProdutoAdquirido(
	produtoID INT REFERENCES Produto,
	pedidoID INT REFERENCES Pedido,
	quantidade INT,
	PRIMARY KEY(produtoID, pedidoID)
);

CREATE TABLE Pessoa(
	pessoaID INT PRIMARY KEY,
	nome TEXT,
	NIF INT,
	telefone INT,
	dataNascimento DATE,
	morada TEXT,
	codigoPostal TEXT
);

CREATE TABLE Funcionario(
	pessoaID INT PRIMARY KEY REFERENCES Pessoa,
	funcoes TEXT,
	salario REAL,
	cinemaID INT REFERENCES Cinema
	postoVendaID INT REFERENCES PostoVenda
);

CREATE TABLE Cliente(
	pessoaID INT PRIMARY KEY REFERENCES Pessoa,
	desconto INT
);

CREATE TABLE Usual(
	clienteID INT PRIMARY KEY REFERENCES Cliente
);

CREATE TABLE Membro(
	clienteID INT PRIMARY KEY REFERENCES Cliente,
	email TEXT,
	cartaoID INT REFERENCES Cartao
);

CREATE TABLE Cartao(
	cartaoID INT PRIMARY KEY,
	numero INT,
	tipo TEXT,
	validade DATE,
	membroID INT REFERENCES Membro
);