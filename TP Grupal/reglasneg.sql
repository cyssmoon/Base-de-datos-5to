DELIMITER $$

CREATE TRIGGER trg_inscripcion_validar
BEFORE INSERT ON Inscripcion
FOR EACH ROW
BEGIN
    DECLARE v_es_socio     INT DEFAULT 0;
    DECLARE v_es_no_socio  INT DEFAULT 0;
    DECLARE v_estado       VARCHAR(20);
    DECLARE v_venc         DATE;
    DECLARE v_pase_valido  INT DEFAULT 0;

    SELECT COUNT(*) INTO v_es_socio    FROM Socio    WHERE dni = NEW.dni_persona;
    SELECT COUNT(*) INTO v_es_no_socio FROM NoSocio  WHERE dni = NEW.dni_persona;

    IF v_es_socio = 1 THEN
        SELECT estado INTO v_estado FROM Socio WHERE dni = NEW.dni_persona;
        SELECT MAX(fecha_vencimiento) INTO v_venc FROM Cuota WHERE dni_socio = NEW.dni_persona;

        IF v_estado <> 'Habilitado' OR v_venc IS NULL OR v_venc < NEW.fecha_inscripcion THEN
            SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'Socio inhabilitado o con cuota vencida: no puede inscribirse a la clase.';
        END IF;

    ELSEIF v_es_no_socio = 1 THEN
        IF NEW.id_pase IS NULL THEN
            SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'El No Socio debe registrar el pago del pase diario antes de inscribirse.';
        ELSE
            SELECT COUNT(*) INTO v_pase_valido
            FROM PaseDiario
            WHERE id_pase = NEW.id_pase
              AND dni_no_socio = NEW.dni_persona
              AND fecha = NEW.fecha_inscripcion;

            IF v_pase_valido = 0 THEN
                SIGNAL SQLSTATE '45000'
                    SET MESSAGE_TEXT = 'El pase diario no corresponde a la persona o a la fecha de inscripción.';
            END IF;
        END IF;
    ELSE
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'La persona debe estar registrada como Socio o No Socio para inscribirse.';
    END IF;
END$$
