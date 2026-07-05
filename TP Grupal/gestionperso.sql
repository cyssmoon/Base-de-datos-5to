DROP DATABASE IF EXISTS club_deportivo;
CREATE DATABASE club_deportivo CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci;
USE club_deportivo;

CREATE TABLE Persona (
    dni             VARCHAR(10)     NOT NULL,
    nombre          VARCHAR(50)     NOT NULL,
    apellido        VARCHAR(50)     NOT NULL,
    telefono        VARCHAR(20)     NULL,
    email           VARCHAR(100)    NULL,
    CONSTRAINT pk_persona PRIMARY KEY (dni),
    CONSTRAINT uq_persona_email UNIQUE (email)
) ENGINE=InnoDB;

CREATE TABLE Socio (
    dni             VARCHAR(10)     NOT NULL,
    nro_carnet      INT             NOT NULL AUTO_INCREMENT,
    estado          ENUM('Habilitado','Inhabilitado') NOT NULL DEFAULT 'Habilitado',
    fecha_alta      DATE            NOT NULL,
    CONSTRAINT pk_socio PRIMARY KEY (dni),
    CONSTRAINT uq_socio_carnet UNIQUE (nro_carnet),
    CONSTRAINT fk_socio_persona FOREIGN KEY (dni) REFERENCES Persona(dni)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT = 1000;

CREATE TABLE NoSocio (
    dni             VARCHAR(10)     NOT NULL,
    CONSTRAINT pk_no_socio PRIMARY KEY (dni),
    CONSTRAINT fk_no_socio_persona FOREIGN KEY (dni) REFERENCES Persona(dni)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE Profesor (
    dni             VARCHAR(10)     NOT NULL,
    legajo          INT             NOT NULL AUTO_INCREMENT,
    sueldo_mensual  DECIMAL(10,2)   NOT NULL,
    CONSTRAINT pk_profesor PRIMARY KEY (dni),
    CONSTRAINT uq_profesor_legajo UNIQUE (legajo),
    CONSTRAINT fk_profesor_persona FOREIGN KEY (dni) REFERENCES Persona(dni)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT chk_sueldo_positivo CHECK (sueldo_mensual > 0)
) ENGINE=InnoDB AUTO_INCREMENT = 5000;
