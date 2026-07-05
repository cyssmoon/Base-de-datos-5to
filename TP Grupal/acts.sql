CREATE TABLE Actividad (
    id_actividad    INT             NOT NULL AUTO_INCREMENT,
    nombre          VARCHAR(50)     NOT NULL,
    descripcion     VARCHAR(200)    NULL,
    CONSTRAINT pk_actividad PRIMARY KEY (id_actividad),
    CONSTRAINT uq_actividad_nombre UNIQUE (nombre)
) ENGINE=InnoDB;

CREATE TABLE Salon (
    id_salon        INT             NOT NULL AUTO_INCREMENT,
    nombre          VARCHAR(50)     NOT NULL,
    capacidad       INT             NOT NULL,
    CONSTRAINT pk_salon PRIMARY KEY (id_salon),
    CONSTRAINT chk_capacidad_positiva CHECK (capacidad > 0)
) ENGINE=InnoDB;

CREATE TABLE Clase (
    id_clase        INT             NOT NULL AUTO_INCREMENT,
    id_actividad    INT             NOT NULL,
    id_salon        INT             NOT NULL,
    dni_profesor    VARCHAR(10)     NOT NULL,
    dia_semana      ENUM('Lunes','Martes','Miercoles','Jueves','Viernes','Sabado') NOT NULL,
    hora_inicio     TIME            NOT NULL,
    hora_fin        TIME            NOT NULL,
    CONSTRAINT pk_clase PRIMARY KEY (id_clase),
    CONSTRAINT fk_clase_actividad FOREIGN KEY (id_actividad) REFERENCES Actividad(id_actividad),
    CONSTRAINT fk_clase_salon FOREIGN KEY (id_salon) REFERENCES Salon(id_salon),
    CONSTRAINT fk_clase_profesor FOREIGN KEY (dni_profesor) REFERENCES Profesor(dni),
    CONSTRAINT chk_horario CHECK (hora_fin > hora_inicio),
    CONSTRAINT uq_salon_horario UNIQUE (id_salon, dia_semana, hora_inicio)
) ENGINE=InnoDB;
