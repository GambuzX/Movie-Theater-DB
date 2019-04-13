DROP TABLE IF EXISTS LugarOcupado;
DROP TABLE IF EXISTS Pedido;
DROP TABLE IF EXISTS Bilhete;
DROP TABLE IF EXISTS FilmeTemCategoria;
DROP TABLE IF EXISTS CinemaTemFilme;
DROP TABLE IF EXISTS ProdutoAdquirido;
DROP TABLE IF EXISTS ProdutoDisponivel;
DROP TABLE IF EXISTS Funcionario;
DROP TABLE IF EXISTS Cinema;
DROP TABLE IF EXISTS Sessao;
DROP TABLE IF EXISTS Sala;
DROP TABLE IF EXISTS SistemaSom;
DROP TABLE IF EXISTS Ecra;
DROP TABLE IF EXISTS Lugar;
DROP TABLE IF EXISTS Filme;
DROP TABLE IF EXISTS Categoria;
DROP TABLE IF EXISTS Critica;
DROP TABLE IF EXISTS PostoVenda;
DROP TABLE IF EXISTS Produto;
DROP TABLE IF EXISTS Membro;
DROP TABLE IF EXISTS Cliente;
DROP TABLE IF EXISTS Pessoa;
DROP TABLE IF EXISTS Adesao;

CREATE TABLE Cinema(
	cinemaID INTEGER CONSTRAINT CinemaPK PRIMARY KEY AUTOINCREMENT,
	nome TEXT UNIQUE NOT NULL,
	telefone INT NOT NULL,
	morada TEXT NOT NULL,
	codigoPostal TEXT NOT NULL,
	email TEXT NOT NULL,
	site TEXT
);

CREATE TABLE Sala(
	salaID INTEGER CONSTRAINT CinemaPK PRIMARY KEY AUTOINCREMENT,
	numero INT NOT NULL,
	cinema INT NOT NULL REFERENCES Cinema ,
	numLugares INT NOT NULL CHECK(numLugares>=0),
	sistemaSom INT NOT NULL REFERENCES SistemaSom ON DELETE CASCADE ON UPDATE CASCADE, /* Must guarantee with trigger that is not null on insert */
	ecra INT NOT NULL REFERENCES Ecra ON DELETE CASCADE ON UPDATE CASCADE, /* Must guarantee with trigger that is not null on insert */
	UNIQUE(numero, cinema)
	FOREIGN KEY(cinema) REFERENCES Cinema(cinemaID) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE SistemaSom(
	sistemaSomID INTEGER CONSTRAINT SistemaSomPK PRIMARY KEY AUTOINCREMENT,
	nome TEXT NOT NULL UNIQUE,
	classificacao INT CHECK(classificacao>=0 and classificacao<=5)
);

CREATE TABLE Ecra(
	ecraID INTEGER CONSTRAINT EcraPK PRIMARY KEY AUTOINCREMENT,
	nome TEXT NOT NULL UNIQUE,
	polegadas REAL CHECK(polegadas>=0),
	classificacao INT CHECK(classificacao>=0 and classificacao<=5)
);

CREATE TABLE Lugar(
	lugarID INTEGER CONSTRAINT LugarPK PRIMARY KEY AUTOINCREMENT,
	sala INT NOT NULL REFERENCES Sala ON DELETE CASCADE ON UPDATE CASCADE,
	fila INT NOT NULL,
	numero INT NOT NULL,
	VIP BOOLEAN NOT NULL CHECK(VIP=0 or VIP=1),
	UNIQUE(sala, fila, numero)
);

CREATE TABLE Filme(
	filmeID INTEGER CONSTRAINT FilmePK PRIMARY KEY AUTOINCREMENT,
	nome TEXT UNIQUE NOT NULL,
	diretor TEXT,
	resumo TEXT,
	duracao INT CHECK(duracao>0),
	dataEstreia DATE
);

CREATE TABLE Sessao(
	sessaoID INTEGER CONSTRAINT SessaoPK PRIMARY KEY AUTOINCREMENT,
	horaInicio TEXT NOT NULL,
	lugaresDisponiveis INT CHECK(lugaresDisponiveis>=0) NOT NULL,
	sala INT NOT NULL REFERENCES Sala ON DELETE CASCADE ON UPDATE CASCADE,
	filme INT NOT NULL REFERENCES Filme ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE LugarOcupado(
	sessao INT NOT NULL REFERENCES Sessao ON DELETE CASCADE ON UPDATE CASCADE,
	lugar INT NOT NULL REFERENCES Lugar ON DELETE CASCADE ON UPDATE CASCADE,
	ocupado BOOLEAN NOT NULL CHECK(ocupado=0 or ocupado=1),
	CONSTRAINT SessaoPK PRIMARY KEY(sessao, lugar)
);

CREATE TABLE Categoria(
	categoriaID INTEGER CONSTRAINT CategoriaPK PRIMARY KEY AUTOINCREMENT,
	nome TEXT UNIQUE NOT NULL,
	descricao TEXT
);

CREATE TABLE Critica(
	criticaID INTEGER CONSTRAINT CriticaPK PRIMARY KEY AUTOINCREMENT,
	autor TEXT NOT NULL,
	filme INT NOT NULL REFERENCES Filme ON DELETE CASCADE ON UPDATE CASCADE,
	classificacao INT CHECK(classificacao>=0 and classificacao<=5) NOT NULL,
	descricao TEXT NOT NULL
);

CREATE TABLE FilmeTemCategoria(
	filme INT NOT NULL REFERENCES Filme ON DELETE CASCADE ON UPDATE CASCADE,
	categoria INT NOT NULL REFERENCES Categoria ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT FilmeTemCategoriaPK PRIMARY KEY(filme, categoria)
);

CREATE TABLE CinemaTemFilme(
	cinema INT NOT NULL REFERENCES Cinema ON DELETE CASCADE ON UPDATE CASCADE,
	filme INT NOT NULL REFERENCES Filme ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT CinemaTemFilmePK PRIMARY KEY(cinema, filme)
);



CREATE TABLE Bilhete(
	bilheteID INTEGER CONSTRAINT BilhetePK PRIMARY KEY AUTOINCREMENT,
	dataCompra DATE NOT NULL,
	sessao INT NOT NULL REFERENCES Sessao ON DELETE CASCADE ON UPDATE CASCADE,
	lugar INT NOT NULL REFERENCES Lugar ON DELETE CASCADE ON UPDATE CASCADE,
	pedido INT NOT NULL REFERENCES Pedido ON DELETE CASCADE ON UPDATE CASCADE,
	UNIQUE(sessao, lugar)
);

CREATE TABLE Pedido(
	pedidoID INTEGER CONSTRAINT PedidoPK PRIMARY KEY AUTOINCREMENT,
	precoOriginal REAL NOT NULL,
	precoEfetivo REAL NOT NULL, /* DERIVADO */
	dataPagamento DATE NOT NULL,
	postoVenda INT NOT NULL REFERENCES PostoVenda ON DELETE CASCADE ON UPDATE CASCADE, /* Must guarantee with trigger that is not null on insert */
	funcionario INT NOT NULL REFERENCES Funcionario ON DELETE CASCADE ON UPDATE CASCADE, /* Must guarantee with trigger that is not null on insert */
	cliente INT NOT NULL REFERENCES Cliente ON DELETE CASCADE ON UPDATE CASCADE /* Must guarantee with trigger that is not null on insert */
);

CREATE TABLE PostoVenda(
	postoVendaID INTEGER CONSTRAINT PostoVendaPK PRIMARY KEY AUTOINCREMENT,
	cinema INT NOT NULL REFERENCES Cinema ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Produto(
	produtoID INTEGER CONSTRAINT ProdutoPK PRIMARY KEY AUTOINCREMENT,
	nome TEXT UNIQUE NOT NULL,
	preco REAL CHECK(preco>=0) NOT NULL
);

CREATE TABLE ProdutoDisponivel(
	produto INT NOT NULL REFERENCES Produto ON DELETE CASCADE ON UPDATE CASCADE,
	postoVenda INT NOT NULL REFERENCES PostoVenda ON DELETE CASCADE ON UPDATE CASCADE,
	stock INT CHECK(stock>=0) NOT NULL,
	CONSTRAINT ProdutoDisponivelPK PRIMARY KEY(produto, postoVenda)
);

CREATE TABLE ProdutoAdquirido(
	produto INT NOT NULL REFERENCES Produto ON DELETE CASCADE ON UPDATE CASCADE,
	pedido INT NOT NULL REFERENCES Pedido ON DELETE CASCADE ON UPDATE CASCADE,
	quantidade INT CHECK(quantidade>=1) NOT NULL,
	CONSTRAINT ProdutoAdquiridoPK PRIMARY KEY(produto, pedido)
);

CREATE TABLE Pessoa(
	pessoaID INTEGER CONSTRAINT PessoaPK PRIMARY KEY AUTOINCREMENT,
	nome TEXT NOT NULL,
	NIF INT UNIQUE NOT NULL,
	telefone INT,
	dataNascimento DATE,
	morada TEXT,
	codigoPostal TEXT
);

CREATE TABLE Funcionario(
	pessoaID INT REFERENCES Pessoa ON DELETE CASCADE ON UPDATE CASCADE,
	funcoes TEXT NOT NULL,
	salario REAL NOT NULL,
	cinema INT REFERENCES Cinema ON DELETE SET NULL ON UPDATE CASCADE,
	postoVenda INT REFERENCES PostoVenda ON DELETE SET NULL ON UPDATE CASCADE,
	numeroTrabalhador INT NOT NULL CHECK(numeroTrabalhador>0),
	CONSTRAINT FuncionarioPK PRIMARY KEY(pessoaID)
);

CREATE TABLE Cliente(
	pessoaID INT REFERENCES Pessoa ON DELETE CASCADE ON UPDATE CASCADE,
	desconto INT DEFAULT 0 CHECK(desconto>=0 and desconto<=100) NOT NULL,
	CONSTRAINT ClientePK PRIMARY KEY(pessoaID)
);

CREATE TABLE Membro(
	clienteID INT REFERENCES Cliente ON DELETE CASCADE ON UPDATE CASCADE,
	email TEXT NOT NULL,
	numeroCartao INT UNIQUE NOT NULL,
	validadeAdesao DATE NOT NULL,
	adesao INT NOT NULL REFERENCES Adesao ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT MembroPK PRIMARY KEY(clienteID)
);

CREATE TABLE Adesao(
	adesaoID INTEGER CONSTRAINT AdesaoPK PRIMARY KEY AUTOINCREMENT,
	tipo TEXT NOT NULL
);
