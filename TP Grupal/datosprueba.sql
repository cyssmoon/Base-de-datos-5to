
USE club_deportivo;

INSERT INTO Persona (dni, nombre, apellido, telefono, email) VALUES
('30111222','Martina','Lopez','1145551111','mlopez@mail.com'),
('29888777','Nicolas','Fernandez','1145552222','nfernandez@mail.com'),
('31222333','Camila','Torres','1145553333','ctorres@mail.com'),
('28555444','Franco','Diaz','1145554444','fdiaz@mail.com'),
('32999888','Julieta','Ramirez','1145555555','jramirez@mail.com'),
('40111222','Ezequiel','Sosa','1145556666','esosa@mail.com'),
('41222333','Valentina','Cruz','1145557777','vcruz@mail.com'),
('42333444','Ignacio','Molina','1145558888','imolina@mail.com'),
('20444555','Diego','Herrera','1145559999','dherrera@mail.com'),
('21555666','Lucia','Fernandez','1145550001','lfernandez@mail.com'),
('22666777','Roberto','Paz','1145550002','rpaz@mail.com'),
('23777888','Marina','Sole','1145550003','msole@mail.com');

INSERT INTO Socio (dni, estado, fecha_alta) VALUES
('30111222','Habilitado','2025-01-10'),
('29888777','Habilitado','2024-11-05'),
('31222333','Habilitado','2025-03-20'),
('28555444','Habilitado','2025-02-15'),
('32999888','Habilitado','2025-06-01');

INSERT INTO NoSocio (dni) VALUES
('40111222'),
('41222333'),
('42333444');

INSERT INTO Profesor (dni, sueldo_mensual) VALUES
('20444555', 650000.00),
('21555666', 600000.00),
('22666777', 700000.00),
('23777888', 680000.00);

INSERT INTO Actividad (nombre, descripcion) VALUES
('Musculacion','Entrenamiento con pesas y máquinas'),
('Spinning','Clase grupal de ciclismo indoor'),
('Natacion','Clases de natación en pileta climatizada'),
('Yoga','Clase de relajación y flexibilidad');

INSERT INTO Salon (nombre, capacidad) VALUES
('Salon A',30),
('Salon B',20),
('Pileta Climatizada',15),
('Salon Relax',12);

INSERT INTO Clase (id_actividad, id_salon, dni_profesor, dia_semana, hora_inicio, hora_fin) VALUES
(1,1,'20444555','Lunes','08:00:00','09:00:00'),
(2,2,'21555666','Martes','18:00:00','19:00:00'),
(3,3,'22666777','Miercoles','10:00:00','11:00:00'),
(4,4,'21555666','Jueves','19:00:00','20:00:00');

INSERT INTO Cuota (dni_socio, fecha_emision, fecha_vencimiento, fecha_pago, monto, estado) VALUES
('30111222','2026-06-05','2026-07-05','2026-06-04', 15000.00,'Pagada');

INSERT INTO Cuota (dni_socio, fecha_emision, fecha_vencimiento, fecha_pago, monto, estado) VALUES
('29888777','2026-05-20','2026-06-20', NULL, 15000.00,'Pendiente');

INSERT INTO Cuota (dni_socio, fecha_emision, fecha_vencimiento, fecha_pago, monto, estado) VALUES
('31222333','2026-06-01','2026-07-01', NULL, 15000.00,'Pendiente');

INSERT INTO Cuota (dni_socio, fecha_emision, fecha_vencimiento, fecha_pago, monto, estado) VALUES
('28555444','2026-06-10','2026-07-10','2026-06-09', 15000.00,'Pagada');

INSERT INTO Cuota (dni_socio, fecha_emision, fecha_vencimiento, fecha_pago, monto, estado) VALUES
('32999888','2026-06-15','2026-07-15','2026-06-14', 15000.00,'Pagada');

CALL sp_registrar_pago_cuota(3, '2026-06-30');

UPDATE Cuota
SET estado = 'Vencida'
WHERE estado = 'Pendiente' AND fecha_vencimiento < '2026-07-05';

UPDATE Socio s
SET s.estado = 'Inhabilitado'
WHERE s.estado = 'Habilitado'
  AND EXISTS (SELECT 1 FROM Cuota c WHERE c.dni_socio = s.dni AND c.estado = 'Vencida');

INSERT INTO PaseDiario (dni_no_socio, fecha, monto) VALUES
('40111222','2026-07-01', 3500.00),
('42333444','2026-07-02', 3500.00);

INSERT INTO Inscripcion (dni_persona, id_clase, fecha_inscripcion, id_pase) VALUES
('30111222', 1, '2026-07-01', NULL),
('28555444', 3, '2026-07-02', NULL),
('32999888', 2, '2026-07-01', NULL);

INSERT INTO Inscripcion (dni_persona, id_clase, fecha_inscripcion, id_pase) VALUES
('40111222', 2, '2026-07-01', 1),
('42333444', 3, '2026-07-02', 2);

INSERT INTO AsistenciaProfesor (dni_profesor, fecha, hora_entrada) VALUES
('20444555','2026-07-01','07:50:00'),
('21555666','2026-07-01','17:45:00'),
('22666777','2026-07-02','09:50:00'),
('21555666','2026-07-02','18:50:00'),
('23777888','2026-07-01','09:00:00');

INSERT INTO PagoSueldo (dni_profesor, periodo_mes, periodo_anio, fecha_pago, monto) VALUES
('20444555', 6, 2026, '2026-06-30', 650000.00),
('21555666', 6, 2026, '2026-06-30', 600000.00),
('22666777', 6, 2026, '2026-06-30', 700000.00),
('23777888', 6, 2026, '2026-06-30', 680000.00);

INSERT INTO TurnoNutricion (dni_socio, fecha, hora, estado) VALUES
('28555444','2026-07-03','10:00:00','Realizado');

INSERT INTO FichaMedica (id_turno, dni_profesional, carga_permitida, observaciones, fecha_consulta) VALUES
(1, '23777888', 'Moderada', 'Paciente apto para actividad moderada, controlar tensión arterial', '2026-07-03');

INSERT INTO Rutina (dni_profesor, dni_socio, id_ficha, carga_asignada, descripcion, fecha_creacion) VALUES
('20444555','28555444', 1, 'Liviana', 'Rutina de adaptación: 20 min cinta + ejercicios livianos con mancuernas', '2026-07-04');

