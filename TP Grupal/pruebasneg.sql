
USE club_deportivo;

-- PRUEBA 1: No Socio sin pase → ERROR esperado
INSERT INTO Inscripcion (dni_persona, id_clase, fecha_inscripcion, id_pase)
VALUES ('41222333', 2, '2026-07-05', NULL);

-- PRUEBA 2: Socio inhabilitado intenta inscribirse → ERROR esperado
INSERT INTO Inscripcion (dni_persona, id_clase, fecha_inscripcion, id_pase)
VALUES ('29888777', 1, '2026-07-05', NULL);

-- PRUEBA 3: Socio inhabilitado pide turno de nutrición → ERROR esperado
INSERT INTO TurnoNutricion (dni_socio, fecha, hora, estado)
VALUES ('29888777', '2026-07-06', '11:00:00', 'Pendiente');

-- PRUEBA 4: Rutina "Intensa" sobre ficha que permite "Moderada" → ERROR esperado
INSERT INTO Rutina (dni_profesor, dni_socio, id_ficha, carga_asignada, descripcion, fecha_creacion)
VALUES ('20444555','28555444', 1, 'Intensa', 'Rutina de alta intensidad', '2026-07-05');

-- PRUEBA 5: Pase de otra fecha → ERROR esperado
INSERT INTO Inscripcion (dni_persona, id_clase, fecha_inscripcion, id_pase)
VALUES ('40111222', 2, '2026-07-04', 1);

