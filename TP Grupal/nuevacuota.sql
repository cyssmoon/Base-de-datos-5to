DELIMITER $$

CREATE PROCEDURE sp_registrar_pago_cuota (
    IN p_id_cuota   INT,
    IN p_fecha_pago DATE
)
BEGIN
    DECLARE v_dni_socio          VARCHAR(10);
    DECLARE v_monto              DECIMAL(8,2);
    DECLARE v_ultimo_dia_mes_sig DATE;
    DECLARE v_dia_pago           INT;
    DECLARE v_primer_dia_mes_sig DATE;
    DECLARE v_prox_vencimiento   DATE;

    UPDATE Cuota
       SET fecha_pago = p_fecha_pago, estado = 'Pagada'
     WHERE id_cuota = p_id_cuota;

    SELECT dni_socio, monto INTO v_dni_socio, v_monto FROM Cuota WHERE id_cuota = p_id_cuota;

    UPDATE Socio SET estado = 'Habilitado' WHERE dni = v_dni_socio;

    SET v_ultimo_dia_mes_sig = LAST_DAY(DATE_ADD(p_fecha_pago, INTERVAL 1 MONTH));
    SET v_dia_pago           = DAY(p_fecha_pago);
    SET v_primer_dia_mes_sig = DATE_SUB(v_ultimo_dia_mes_sig, INTERVAL DAY(v_ultimo_dia_mes_sig) - 1 DAY);

    IF v_dia_pago <= DAY(v_ultimo_dia_mes_sig) THEN
        SET v_prox_vencimiento = DATE_ADD(v_primer_dia_mes_sig, INTERVAL v_dia_pago - 1 DAY);
    ELSE
        SET v_prox_vencimiento = DATE_ADD(v_ultimo_dia_mes_sig, INTERVAL 1 DAY);
    END IF;

    INSERT INTO Cuota (dni_socio, fecha_emision, fecha_vencimiento, monto, estado)
    VALUES (v_dni_socio, p_fecha_pago, v_prox_vencimiento, v_monto, 'Pendiente');
END$$

DELIMITER ;
