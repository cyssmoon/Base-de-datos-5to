DROP DATABASE IF EXISTS empresa;
CREATE DATABASE empresa;
USE empresa;

CREATE TABLE proveedores(
NIF CHAR(50) PRIMARY KEY,
nombre CHAR(50),
direccion CHAR(50)
);

CREATE TABLE productos( 
codigo INT PRIMARY KEY,
nombre CHAR(50),
precio DECIMAL (10,2),
NIF_provee CHAR(11),
FOREIGN KEY(NIF_provee) REFERENCES proveedores(NIF)
);


CREATE TABLE clientes(
DNI int PRIMARY KEY,
nombre CHAR(15),
apellidos CHAR(15),
direccion VARCHAR(15),
fecha_nac DATE
);

CREATE TABLE compras(
    ID INT, 
    dni_comp INT,
    codigo_prod INT,
    PRIMARY KEY (dni_comp, codigo_prod),
    FOREIGN KEY (dni_comp) REFERENCES cliente(dni),
    FOREIGN KEY (codigo_prod) REFERENCES productos(codigo)      
);
//esta mal compras, tengo q corregirlo en casa mi cerebro se frito en clase 
