DROP DATABASE hospital;
CREATE DATABASE hospital;
USE hospital;


 CREATE TABLE Medicos (
    dni INT PRIMARY KEY,
    nombre VARCHAR(50),
    especialidad VARCHAR(50),
    matricula INT UNIQUE
);


CREATE TABLE Pacientes (
    dni INT PRIMARY KEY,
    nombre VARCHAR(50),
    direccion VARCHAR(100),
    grupo_sanguineo VARCHAR(5)
);


CREATE TABLE Turnos (
    id_turno INT AUTO_INCREMENT PRIMARY KEY,
    fecha DATE,
    hora TIME,
    consultorio VARCHAR(20),
    dni_paciente INT,
    dni_medico INT,
    FOREIGN KEY (dni_paciente) REFERENCES Pacientes(dni),
    FOREIGN KEY (dni_medico) REFERENCES Medicos(dni),
    UNIQUE (dni_paciente, dni_medico, fecha, hora)
);


CREATE TABLE Ingresos (
    id_ingreso INT AUTO_INCREMENT PRIMARY KEY,
    fecha_entrada DATE,
    cama VARCHAR(10),
    diagnostico VARCHAR(100),
    dni_paciente INT,
    dni_medico INT,
    FOREIGN KEY (dni_paciente) REFERENCES Pacientes(dni),
    FOREIGN KEY (dni_medico) REFERENCES Medicos(dni)
);
