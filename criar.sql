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
	cinemaID INT PRIMARY KEY AUTOINCREMENT,
	nome TEXT UNIQUE NOT NULL,
	telefone INT NOT NULL,
	morada TEXT NOT NULL,
	codigoPostal TEXT NOT NULL,
	email TEXT NOT NULL,
	site TEXT
);

CREATE TABLE Sala(
	salaID INT PRIMARY KEY AUTOINCREMENT,
	numero INT NOT NULL,
	cinema INT NOT NULL REFERENCES Cinema,
	numLugares INT NOT NULL CHECK(numLugares>=0),
	sistemaSom INT NOT NULL REFERENCES SistemaSom,
	ecra INT NOT NULL REFERENCES Ecra,
	UNIQUE(numero, cinema)
);

CREATE TABLE SistemaSom(
	sistemaSomID INT PRIMARY KEY AUTOINCREMENT,
	nome TEXT NOT NULL UNIQUE,
	classificacao INT CHECK(classificacao>=0 and classificacao<=5)
);

CREATE TABLE Ecra(
	ecraID INT PRIMARY KEY AUTOINCREMENT,
	nome TEXT NOT NULL UNIQUE,
	polegadas REAL CHECK(polegadas>=0),
	classificacao INT CHECK(classificacao>=0 and classificacao<=5)

);

CREATE TABLE Lugar(
	lugarID INT PRIMARY KEY AUTOINCREMENT,
	sala INT NOT NULL REFERENCES Sala,
	fila INT NOT NULL,
	numero INT NOT NULL,
	VIP BOOLEAN NOT NULL CHECK(VIP=0 or VIP=1),
	UNIQUE(sala, fila, numero)
);

CREATE TABLE LugarOcupado(
	sessao INT REFERENCES Sessao,
	lugar INT REFERENCES Lugar,
	ocupado BOOLEAN NOT NULL CHECK(ocupado=0 or ocupado=1),
	PRIMARY KEY(sessao, lugar)
);

CREATE TABLE Filme(
	filmeID INT PRIMARY KEY AUTOINCREMENT,
	nome TEXT UNIQUE NOT NULL,
	diretor TEXT,
	resumo TEXT,
	duracao INT CHECK(duracao>0),
	dataEstreia DATE
);

CREATE TABLE Categoria(
	categoriaID INT PRIMARY KEY AUTOINCREMENT,
	nome TEXT UNIQUE NOT NULL,
	descricao TEXT
);

CREATE TABLE Critica(
	criticaID INT PRIMARY KEY AUTOINCREMENT,
	autor TEXT NOT NULL,
	filme INT REFERENCES Filme,
	classificacao INT CHECK(classificacao>=0 and classificacao<=5) NOT NULL,
	descricao TEXT NOT NULL
);

CREATE TABLE FilmeTemCategoria(
	filme INT REFERENCES Filme NOT NULL,
	categoria INT REFERENCES Categoria NOT NULL,
	PRIMARY KEY(filme, categoria)
);

CREATE TABLE CinemaTemFilme(
	cinema INT REFERENCES Cinema NOT NULL,
	filme INT REFERENCES Filme NOT NULL,
	PRIMARY KEY(cinema, filme)
);


CREATE TABLE Sessao(
	sessaoID INT PRIMARY KEY AUTOINCREMENT,
	horaInicio TEXT NOT NULL,
	lugaresDisponiveis INT CHECK(lugaresDisponiveis>=0) NOT NULL,
	sala INT REFERENCES Sala NOT NULL,
	filme INT REFERENCES Filme NOT NULL
);

CREATE TABLE Bilhete(
	bilheteID INT PRIMARY KEY AUTOINCREMENT,
	dataCompra DATE NOT NULL,
	sessao INT REFERENCES Sessao NOT NULL,
	lugar INT REFERENCES Lugar NOT NULL,
	pedido INT REFERENCES Pedido NOT NULL,
	UNIQUE(sessao, lugar)
);

CREATE TABLE Pedido(
	pedidoID INT PRIMARY KEY AUTOINCREMENT,
	precoOriginal REAL NOT NULL,
	precoEfetivo REAL NOT NULL, /* DERIVADO */
	dataPagamento DATE NOT NULL,
	postoVenda INT REFERENCES PostoVenda NOT NULL,
	funcionario INT REFERENCES Funcionario NOT NULL,
	cliente INT REFERENCES Cliente NOT NULL
);

CREATE TABLE PostoVenda(
	postoVendaID INT PRIMARY KEY AUTOINCREMENT,
	cinema INT REFERENCES Cinema NOT NULL
);

CREATE TABLE Produto(
	produtoID INT PRIMARY KEY AUTOINCREMENT,
	nome TEXT UNIQUE NOT NULL,
	preco REAL CHECK(preco>=0) NOT NULL
);

CREATE TABLE ProdutoDisponivel(
	produto INT REFERENCES Produto NOT NULL,
	postoVenda INT REFERENCES PostoVenda NOT NULL,
	stock INT CHECK(stock>=0) NOT NULL,
	PRIMARY KEY(produto, postoVenda)
);

CREATE TABLE ProdutoAdquirido(
	produto INT REFERENCES Produto NOT NULL,
	pedido INT REFERENCES Pedido NOT NULL,
	quantidade INT CHECK(quantidade>=1) NOT NULL,
	PRIMARY KEY(produto, pedido)
);	

CREATE TABLE Pessoa(
	pessoaID INT PRIMARY KEY AUTOINCREMENT,
	nome TEXT NOT NULL,
	NIF INT UNIQUE NOT NULL,
	telefone INT,
	dataNascimento DATE,
	morada TEXT,
	codigoPostal TEXT
);

CREATE TABLE Funcionario(
	pessoaID INT PRIMARY KEY REFERENCES Pessoa,
	funcoes TEXT NOT NULL,
	salario REAL NOT NULL,
	cinema INT REFERENCES Cinema NOT NULL,
	postoVenda INT REFERENCES PostoVenda NOT NULL,
	numeroTrabalhador INT NOT NULL CHECK(numeroTrabalhador>0)
);

CREATE TABLE Cliente(
	pessoaID INT PRIMARY KEY REFERENCES Pessoa,
	desconto INT CHECK(desconto>=0 and desconto<=100) NOT NULL
);

CREATE TABLE Usual(
	clienteID INT PRIMARY KEY REFERENCES cliente
);

CREATE TABLE Membro(
	clienteID INT PRIMARY KEY REFERENCES Cliente,
	email TEXT NOT NULL,
	cartao INT REFERENCES Cartao NOT NULL
);

CREATE TABLE Cartao(
	cartaoID INT PRIMARY KEY AUTOINCREMENT,
	numero INT UNIQUE NOT NULL,
	tipo TEXT NOT NULL,
	validade DATE NOT NULL,
	membro INT REFERENCES Membro NOT NULL
);