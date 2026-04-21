DROP DATABASE IF EXISTS Seguros;
CREATE DATABASE Seguros;
USE Seguros;


CREATE TABLE Clientes (
    DNI INT PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL,
    Apellido VARCHAR(50) NOT NULL,
    Direccion VARCHAR(100),
    Telefono VARCHAR(20),
    Cuenta_bancaria VARCHAR(30),
    Fecha_nacimiento DATE,
    Sexo CHAR(1),
    Anio_carnet YEAR
);


CREATE TABLE Vehiculos (
    Patente VARCHAR(10) PRIMARY KEY,
    Tipo_seguro VARCHAR(50),
    Marca VARCHAR(50),
    Modelo VARCHAR(50),
    Color VARCHAR(30),
    DNI_cliente INT,
    FOREIGN KEY (DNI_cliente) REFERENCES Clientes(DNI)
);


CREATE TABLE Accidentes (
    Codigo_accidente INT PRIMARY KEY,
    Lugar VARCHAR(100),
    Fecha DATE,
    Hora TIME,
    Nro_vehiculos INT,
    Patente VARCHAR(10),
    FOREIGN KEY (Patente) REFERENCES Vehiculos(Patente)
);


