
CREATE TABLE AsistenciaProfesor (
    id_asistencia   INT             NOT NULL AUTO_INCREMENT,
    dni_profesor    VARCHAR(10)     NOT NULL,
    fecha           DATE            NOT NULL,
    hora_entrada    TIME            NOT NULL,
    CONSTRAINT pk_asistencia PRIMARY KEY (id_asistencia),
    CONSTRAINT fk_asistencia_profesor FOREIGN KEY (dni_profesor) REFERENCES Profesor(dni),
    CONSTRAINT uq_asistencia_dia UNIQUE (dni_profesor, fecha)
) ENGINE=InnoDB;

CREATE TABLE PagoSueldo (
    id_pago         INT             NOT NULL AUTO_INCREMENT,
    dni_profesor    VARCHAR(10)     NOT NULL,
    periodo_mes     TINYINT         NOT NULL,
    periodo_anio    SMALLINT        NOT NULL,
    fecha_pago      DATE            NOT NULL,
    monto           DECIMAL(10,2)   NOT NULL,
    CONSTRAINT pk_pago_sueldo PRIMARY KEY (id_pago),
    CONSTRAINT fk_pago_profesor FOREIGN KEY (dni_profesor) REFERENCES Profesor(dni),
    CONSTRAINT chk_mes_valido CHECK (periodo_mes BETWEEN 1 AND 12),
    CONSTRAINT uq_pago_periodo UNIQUE (dni_profesor, periodo_mes, periodo_anio)
) ENGINE=InnoDB;
