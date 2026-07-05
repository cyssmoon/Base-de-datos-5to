DELIMITER $$

CREATE EVENT IF NOT EXISTS evt_inhabilitar_socios
ON SCHEDULE EVERY 1 DAY
STARTS (TIMESTAMP(CURRENT_DATE) + INTERVAL 1 DAY + INTERVAL 1 HOUR)
DO
BEGIN
    UPDATE Cuota
    SET estado = 'Vencida'
    WHERE estado = 'Pendiente' AND fecha_vencimiento < CURDATE();

    UPDATE Socio s
    SET s.estado = 'Inhabilitado'
    WHERE s.estado = 'Habilitado'
      AND EXISTS (
            SELECT 1 FROM Cuota c
            WHERE c.dni_socio = s.dni AND c.estado = 'Vencida'
      );
END$$

DELIMITER ;
