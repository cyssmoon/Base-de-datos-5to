CREATE TRIGGER trg_turno_validar
BEFORE INSERT ON TurnoNutricion
FOR EACH ROW
BEGIN
    DECLARE v_estado VARCHAR(20);
    DECLARE v_venc   DATE;

    SELECT estado INTO v_estado FROM Socio WHERE dni = NEW.dni_socio;
    SELECT MAX(fecha_vencimiento) INTO v_venc FROM Cuota WHERE dni_socio = NEW.dni_socio;

    IF v_estado <> 'Habilitado' OR v_venc IS NULL OR v_venc < NEW.fecha THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'El socio debe estar habilitado y al día para solicitar un turno de nutrición.';
    END IF;
END$$

CREATE TRIGGER trg_rutina_validar_carga
BEFORE INSERT ON Rutina
FOR EACH ROW
BEGIN
    DECLARE v_carga_permitida VARCHAR(20);
    DECLARE v_rank_permitida  INT;
    DECLARE v_rank_asignada   INT;

    SELECT carga_permitida INTO v_carga_permitida FROM FichaMedica WHERE id_ficha = NEW.id_ficha;

    SET v_rank_permitida = CASE v_carga_permitida
        WHEN 'Liviana' THEN 1 WHEN 'Moderada' THEN 2 WHEN 'Intensa' THEN 3 END;
    SET v_rank_asignada = CASE NEW.carga_asignada
        WHEN 'Liviana' THEN 1 WHEN 'Moderada' THEN 2 WHEN 'Intensa' THEN 3 END;

    IF v_rank_asignada > v_rank_permitida THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'La carga de la rutina excede la carga física permitida por la ficha médica.';
    END IF;
END$$

DELIMITER ;
