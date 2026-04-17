DROP DATABASE tienda;
CREATE DATABASE tienda;
USE tienda;

CREATE TABLE Categorias (
    id_categoria INT PRIMARY KEY,
    nombre VARCHAR(100)
);

CREATE TABLE Productos (
    codigo_producto INT PRIMARY KEY,
    descripcion VARCHAR(255),
    precio_base DECIMAL(10,2),
    stock INT,
    id_categoria INT,
    FOREIGN KEY (id_categoria) REFERENCES Categorias(id_categoria)
);

CREATE TABLE Cupones (
    codigo_cupon VARCHAR(20) PRIMARY KEY,
    porcentaje_descuento DECIMAL(5,2)
);

CREATE TABLE Pedidos (
    numero_factura INT PRIMARY KEY,
    fecha DATE,
    estado VARCHAR(20),
    codigo_cupon VARCHAR(20),
    FOREIGN KEY (codigo_cupon) REFERENCES Cupones(codigo_cupon)
);

CREATE TABLE Detalle_Pedido (
    numero_factura INT,
    codigo_producto INT,
    cantidad INT,
    precio_unitario_historico DECIMAL(10,2),
    PRIMARY KEY (numero_factura, codigo_producto),
    FOREIGN KEY (numero_factura) REFERENCES Pedidos(numero_factura),
    FOREIGN KEY (codigo_producto) REFERENCES Productos(codigo_producto)
);

