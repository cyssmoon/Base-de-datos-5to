CREATE TABLE Cuota (
    id_cuota            INT             NOT NULL AUTO_INCREMENT,
    dni_socio           VARCHAR(10)     NOT NULL,
    fecha_emision       DATE            NOT NULL,
    fecha_vencimiento   DATE            NOT NULL,
    fecha_pago          DATE            NULL,
    monto               DECIMAL(8,2)    NOT NULL,
    estado              ENUM('Pendiente','Pagada','Vencida') NOT NULL DEFAULT 'Pendiente',
    CONSTRAINT pk_cuota PRIMARY KEY (id_cuota),
    CONSTRAINT fk_cuota_socio FOREIGN KEY (dni_socio) REFERENCES Socio(dni),
    CONSTRAINT chk_monto_cuota CHECK (monto > 0),
    CONSTRAINT chk_fechas_cuota CHECK (fecha_vencimiento > fecha_emision)
) ENGINE=InnoDB;
