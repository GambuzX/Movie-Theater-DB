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
DROP TABLE IF EXISTS Membro;
DROP TABLE IF EXISTS Adesao;

CREATE TABLE Cinema(
	cinemaID INTEGER PRIMARY KEY AUTOINCREMENT,
	nome TEXT UNIQUE NOT NULL,
	telefone INT NOT NULL,
	morada TEXT NOT NULL,
	codigoPostal TEXT NOT NULL,
	email TEXT NOT NULL,
	site TEXT
);

CREATE TABLE Sala(
	salaID INTEGER PRIMARY KEY AUTOINCREMENT,
	numero INT NOT NULL,
	cinema INT NOT NULL REFERENCES Cinema,
	numLugares INT NOT NULL CHECK(numLugares>=0),
	sistemaSom INT NOT NULL REFERENCES SistemaSom,
	ecra INT NOT NULL REFERENCES Ecra,
	UNIQUE(numero, cinema)
);

CREATE TABLE SistemaSom(
	sistemaSomID INTEGER PRIMARY KEY AUTOINCREMENT,
	nome TEXT NOT NULL UNIQUE,
	classificacao INT CHECK(classificacao>=0 and classificacao<=5)
);

CREATE TABLE Ecra(
	ecraID INTEGER PRIMARY KEY AUTOINCREMENT,
	nome TEXT NOT NULL UNIQUE,
	polegadas REAL CHECK(polegadas>=0),
	classificacao INT CHECK(classificacao>=0 and classificacao<=5)

);

CREATE TABLE Lugar(
	lugarID INTEGER PRIMARY KEY AUTOINCREMENT,
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
	filmeID INTEGER PRIMARY KEY AUTOINCREMENT,
	nome TEXT UNIQUE NOT NULL,
	diretor TEXT,
	resumo TEXT,
	duracao INT CHECK(duracao>0),
	dataEstreia DATE
);

CREATE TABLE Categoria(
	categoriaID INTEGER PRIMARY KEY AUTOINCREMENT,
	nome TEXT UNIQUE NOT NULL,
	descricao TEXT
);

CREATE TABLE Critica(
	criticaID INTEGER PRIMARY KEY AUTOINCREMENT,
	autor TEXT NOT NULL,
	filme INT REFERENCES Filme,
	classificacao INT CHECK(classificacao>=0 and classificacao<=5) NOT NULL,
	descricao TEXT NOT NULL
);

CREATE TABLE FilmeTemCategoria(
	filme INT REFERENCES Filme,
	categoria INT REFERENCES Categoria,
	PRIMARY KEY(filme, categoria)
);

CREATE TABLE CinemaTemFilme(
	cinema INT REFERENCES Cinema,
	filme INT REFERENCES Filme,
	PRIMARY KEY(cinema, filme)
);


CREATE TABLE Sessao(
	sessaoID INTEGER PRIMARY KEY AUTOINCREMENT,
	horaInicio TEXT NOT NULL,
	lugaresDisponiveis INT CHECK(lugaresDisponiveis>=0) NOT NULL,
	sala INT REFERENCES Sala NOT NULL,
	filme INT REFERENCES Filme NOT NULL
);

CREATE TABLE Bilhete(
	bilheteID INTEGER PRIMARY KEY AUTOINCREMENT,
	dataCompra DATE NOT NULL,
	sessao INT REFERENCES Sessao NOT NULL,
	lugar INT REFERENCES Lugar NOT NULL,
	pedido INT REFERENCES Pedido NOT NULL,
	UNIQUE(sessao, lugar)
);

CREATE TABLE Pedido(
	pedidoID INTEGER PRIMARY KEY AUTOINCREMENT,
	precoOriginal REAL NOT NULL,
	precoEfetivo REAL NOT NULL, /* DERIVADO */
	dataPagamento DATE NOT NULL,
	postoVenda INT REFERENCES PostoVenda NOT NULL,
	funcionario INT REFERENCES Funcionario NOT NULL,
	cliente INT REFERENCES Cliente NOT NULL
);

CREATE TABLE PostoVenda(
	postoVendaID INTEGER PRIMARY KEY AUTOINCREMENT,
	cinema INT REFERENCES Cinema NOT NULL
);

CREATE TABLE Produto(
	produtoID INTEGER PRIMARY KEY AUTOINCREMENT,
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
	pessoaID INTEGER PRIMARY KEY AUTOINCREMENT,
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
	desconto INT DEFAULT 0 CHECK(desconto>=0 and desconto<=100) NOT NULL
);

CREATE TABLE Membro(
	clienteID INT PRIMARY KEY REFERENCES Cliente,
	email TEXT NOT NULL,
	numeroCartao INT UNIQUE NOT NULL,
	validadeAdesao DATE NOT NULL,
	adesao INT REFERENCES Adesao NOT NULL
);

CREATE TABLE Adesao(
	adesaoID INTEGER PRIMARY KEY AUTOINCREMENT,
	tipo TEXT NOT NULL
);
