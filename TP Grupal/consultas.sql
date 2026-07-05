
USE club_deportivo;

-- 1) VENCIMIENTOS DIARIOS
SELECT p.dni, p.nombre, p.apellido, s.nro_carnet,
       c.id_cuota, c.fecha_vencimiento, c.monto, c.estado
FROM Cuota c
JOIN Socio   s ON s.dni = c.dni_socio
JOIN Persona p ON p.dni = s.dni
WHERE c.fecha_vencimiento = '2026-07-05'
ORDER BY c.fecha_vencimiento;

SELECT p.nombre, p.apellido, s.nro_carnet, c.fecha_vencimiento, c.estado
FROM Cuota c
JOIN Socio s ON s.dni = c.dni_socio
JOIN Persona p ON p.dni = s.dni
WHERE c.estado = 'Pendiente'
  AND c.fecha_vencimiento BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 7 DAY)
ORDER BY c.fecha_vencimiento;

-- 2) ESTADO ACTUAL DE UN SOCIO
SELECT p.dni, p.nombre, p.apellido, s.nro_carnet, s.estado AS estado_socio,
       c.fecha_vencimiento AS ultimo_vencimiento,
       c.estado            AS estado_ultima_cuota,
       CASE WHEN c.fecha_vencimiento >= CURDATE() THEN 'Al dia' ELSE 'Adeuda' END AS situacion
FROM Socio s
JOIN Persona p ON p.dni = s.dni
LEFT JOIN Cuota c ON c.dni_socio = s.dni
WHERE s.dni = '29888777'
ORDER BY c.fecha_vencimiento DESC
LIMIT 1;

SELECT p.nombre, p.apellido, s.nro_carnet, s.estado,
       MAX(c.fecha_vencimiento) AS ultimo_vencimiento
FROM Socio s
JOIN Persona p ON p.dni = s.dni
LEFT JOIN Cuota c ON c.dni_socio = s.dni
GROUP BY s.dni, p.nombre, p.apellido, s.nro_carnet, s.estado
ORDER BY s.estado, ultimo_vencimiento;

-- 3) LISTADO DE ALUMNOS
SELECT a.nombre AS actividad, cl.dia_semana, cl.hora_inicio,
       p.dni, p.nombre, p.apellido,
       CASE WHEN so.dni IS NOT NULL THEN 'Socio' ELSE 'No Socio' END AS tipo,
       i.fecha_inscripcion
FROM Inscripcion i
JOIN Clase cl      ON cl.id_clase = i.id_clase
JOIN Actividad a   ON a.id_actividad = cl.id_actividad
JOIN Persona p     ON p.dni = i.dni_persona
LEFT JOIN Socio so ON so.dni = p.dni
ORDER BY a.nombre, cl.dia_semana, p.apellido;

SELECT p.nombre, p.apellido, i.fecha_inscripcion
FROM Inscripcion i
JOIN Clase cl ON cl.id_clase = i.id_clase
JOIN Actividad a ON a.id_actividad = cl.id_actividad
JOIN Persona p ON p.dni = i.dni_persona
WHERE a.nombre = 'Spinning';

-- 4) LISTADO GENERAL DE SOCIOS Y NO SOCIOS
SELECT p.dni, p.nombre, p.apellido, 'Socio' AS tipo, s.nro_carnet AS identificador, s.estado
FROM Socio s JOIN Persona p ON p.dni = s.dni
UNION ALL
SELECT p.dni, p.nombre, p.apellido, 'No Socio' AS tipo, NULL AS identificador, NULL AS estado
FROM NoSocio n JOIN Persona p ON p.dni = n.dni
ORDER BY apellido;

-- 5) CLASES POR ACTIVIDAD, SALÓN Y PROFESOR
SELECT a.nombre AS actividad, cl.dia_semana, cl.hora_inicio, cl.hora_fin,
       sa.nombre AS salon, p.nombre AS profesor_nombre, p.apellido AS profesor_apellido
FROM Clase cl
JOIN Actividad a ON a.id_actividad = cl.id_actividad
JOIN Salon sa    ON sa.id_salon = cl.id_salon
JOIN Profesor pr ON pr.dni = cl.dni_profesor
JOIN Persona p   ON p.dni = pr.dni
ORDER BY cl.dia_semana, cl.hora_inicio;

-- 6) HISTORIAL DE PAGOS DE CUOTAS DE UN SOCIO
SELECT p.nombre, p.apellido, c.fecha_emision, c.fecha_vencimiento, c.fecha_pago, c.monto, c.estado
FROM Cuota c
JOIN Socio s ON s.dni = c.dni_socio
JOIN Persona p ON p.dni = s.dni
WHERE s.dni = '31222333'
ORDER BY c.fecha_emision;

-- 7) ASISTENCIA DE PROFESORES EN UN RANGO DE FECHAS
SELECT p.nombre, p.apellido, ap.fecha, ap.hora_entrada
FROM AsistenciaProfesor ap
JOIN Profesor pr ON pr.dni = ap.dni_profesor
JOIN Persona p ON p.dni = pr.dni
WHERE ap.fecha BETWEEN '2026-07-01' AND '2026-07-05'
ORDER BY ap.fecha, ap.hora_entrada;

-- 8) SUELDOS PAGADOS EN UN PERÍODO
SELECT p.nombre, p.apellido, ps.periodo_mes, ps.periodo_anio, ps.fecha_pago, ps.monto
FROM PagoSueldo ps
JOIN Profesor pr ON pr.dni = ps.dni_profesor
JOIN Persona p ON p.dni = pr.dni
WHERE ps.periodo_mes = 6 AND ps.periodo_anio = 2026
ORDER BY p.apellido;

-- 9) FICHAS MÉDICAS Y RUTINAS ASOCIADAS
SELECT p.nombre AS socio_nombre, p.apellido AS socio_apellido,
       fm.carga_permitida, fm.fecha_consulta,
       r.carga_asignada, r.descripcion AS rutina, pr_p.nombre AS profesor_nombre
FROM FichaMedica fm
JOIN TurnoNutricion tn ON tn.id_turno = fm.id_turno
JOIN Socio s ON s.dni = tn.dni_socio
JOIN Persona p ON p.dni = s.dni
LEFT JOIN Rutina r ON r.id_ficha = fm.id_ficha
LEFT JOIN Profesor pr ON pr.dni = r.dni_profesor
LEFT JOIN Persona pr_p ON pr_p.dni = pr.dni;

-- 10) OCUPACIÓN DE SALONES
SELECT sa.nombre AS salon, COUNT(*) AS cantidad_clases
FROM Clase cl
JOIN Salon sa ON sa.id_salon = cl.id_salon
GROUP BY sa.nombre
ORDER BY cantidad_clases DESC;

-- 11) SOCIOS INHABILITADOS ACTUALMENTE
SELECT p.nombre, p.apellido, p.telefono, s.nro_carnet,
       MAX(c.fecha_vencimiento) AS ultimo_vencimiento
FROM Socio s
JOIN Persona p ON p.dni = s.dni
JOIN Cuota c ON c.dni_socio = s.dni
WHERE s.estado = 'Inhabilitado'
GROUP BY p.nombre, p.apellido, p.telefono, s.nro_carnet;

