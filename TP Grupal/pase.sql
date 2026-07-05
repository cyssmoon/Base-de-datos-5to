CREATE TABLE PaseDiario (
    id_pase         INT             NOT NULL AUTO_INCREMENT,
    dni_no_socio    VARCHAR(10)     NOT NULL,
    fecha           DATE            NOT NULL,
    monto           DECIMAL(8,2)    NOT NULL,
    CONSTRAINT pk_pase PRIMARY KEY (id_pase),
    CONSTRAINT fk_pase_no_socio FOREIGN KEY (dni_no_socio) REFERENCES NoSocio(dni),
    CONSTRAINT chk_monto_pase CHECK (monto > 0),
    CONSTRAINT uq_pase_persona_fecha UNIQUE (dni_no_socio, fecha)
) ENGINE=InnoDB;

CREATE TABLE Inscripcion (
    id_inscripcion      INT             NOT NULL AUTO_INCREMENT,
    dni_persona         VARCHAR(10)     NOT NULL,
    id_clase            INT             NOT NULL,
    fecha_inscripcion   DATE            NOT NULL,
    id_pase             INT             NULL,
    CONSTRAINT pk_inscripcion PRIMARY KEY (id_inscripcion),
    CONSTRAINT fk_inscripcion_persona FOREIGN KEY (dni_persona) REFERENCES Persona(dni),
    CONSTRAINT fk_inscripcion_clase FOREIGN KEY (id_clase) REFERENCES Clase(id_clase),
    CONSTRAINT fk_inscripcion_pase FOREIGN KEY (id_pase) REFERENCES PaseDiario(id_pase),
    CONSTRAINT uq_inscripcion UNIQUE (dni_persona, id_clase, fecha_inscripcion)
) ENGINE=InnoDB;
