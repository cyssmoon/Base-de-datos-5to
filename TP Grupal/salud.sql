
CREATE TABLE TurnoNutricion (
    id_turno        INT             NOT NULL AUTO_INCREMENT,
    dni_socio       VARCHAR(10)     NOT NULL,
    fecha           DATE            NOT NULL,
    hora            TIME            NOT NULL,
    estado          ENUM('Pendiente','Realizado','Cancelado') NOT NULL DEFAULT 'Pendiente',
    CONSTRAINT pk_turno PRIMARY KEY (id_turno),
    CONSTRAINT fk_turno_socio FOREIGN KEY (dni_socio) REFERENCES Socio(dni)
) ENGINE=InnoDB;

CREATE TABLE FichaMedica (
    id_ficha            INT             NOT NULL AUTO_INCREMENT,
    id_turno            INT             NOT NULL,
    dni_profesional     VARCHAR(10)     NOT NULL,
    carga_permitida     ENUM('Liviana','Moderada','Intensa') NOT NULL,
    observaciones        VARCHAR(300)    NULL,
    fecha_consulta      DATE            NOT NULL,
    CONSTRAINT pk_ficha PRIMARY KEY (id_ficha),
    CONSTRAINT fk_ficha_turno FOREIGN KEY (id_turno) REFERENCES TurnoNutricion(id_turno),
    CONSTRAINT fk_ficha_profesional FOREIGN KEY (dni_profesional) REFERENCES Profesor(dni),
    CONSTRAINT uq_ficha_turno UNIQUE (id_turno)
) ENGINE=InnoDB;

CREATE TABLE Rutina (
    id_rutina           INT             NOT NULL AUTO_INCREMENT,
    dni_profesor        VARCHAR(10)     NOT NULL,
    dni_socio           VARCHAR(10)     NOT NULL,
    id_ficha            INT             NOT NULL,
    carga_asignada      ENUM('Liviana','Moderada','Intensa') NOT NULL,
    descripcion         VARCHAR(300)    NOT NULL,
    fecha_creacion      DATE            NOT NULL,
    CONSTRAINT pk_rutina PRIMARY KEY (id_rutina),
    CONSTRAINT fk_rutina_profesor FOREIGN KEY (dni_profesor) REFERENCES Profesor(dni),
    CONSTRAINT fk_rutina_socio FOREIGN KEY (dni_socio) REFERENCES Socio(dni),
    CONSTRAINT fk_rutina_ficha FOREIGN KEY (id_ficha) REFERENCES FichaMedica(id_ficha)
) ENGINE=InnoDB;
