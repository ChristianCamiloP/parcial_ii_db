create database parcial_ii;
use parcial_ii;

CREATE TABLE direccion (
    id_direccion INT PRIMARY KEY AUTO_INCREMENT,
    No_calle VARCHAR(50),
    colonia VARCHAR(50),
    No_casa VARCHAR(20)
);

CREATE TABLE persona (
    No_identidad VARCHAR(20) PRIMARY KEY,
    nombre VARCHAR(100),
    telefono VARCHAR(15),
    id_direccion INT,
    FOREIGN KEY (id_direccion) REFERENCES direccion(id_direccion)
);


CREATE TABLE alumno (
    id_alumno VARCHAR(20) PRIMARY KEY,
    id_persona_responsable VARCHAR(20),
    FOREIGN KEY (id_alumno) REFERENCES persona(No_identidad),
    FOREIGN KEY (id_persona_responsable) REFERENCES persona(No_identidad)
);

CREATE TABLE empleado (
    id_empleado VARCHAR(20) PRIMARY KEY,
    no_seguros VARCHAR(20),
    sueldo_base DECIMAL(10,2),
    horas_trabajo INT,
    FOREIGN KEY (id_empleado) REFERENCES persona(No_identidad)
);

CREATE TABLE EAdministrativo (
    id_EAdmin VARCHAR(20) PRIMARY KEY,
    cargo VARCHAR(50),
    departamento VARCHAR(50),
    FOREIGN KEY (id_EAdmin) REFERENCES empleado(id_empleado)
);

CREATE TABLE maestro (
    id_maestro VARCHAR(20) PRIMARY KEY,
    AreaDocencia VARCHAR(50),
    FOREIGN KEY (id_maestro) REFERENCES empleado(id_empleado)
);

CREATE TABLE usuario (
    id_usuario INT PRIMARY KEY AUTO_INCREMENT,
    tipo_usuario ENUM('admin', 'alumno', 'maestro'),
    nombre_usuario VARCHAR(50) UNIQUE,
    pass VARCHAR(255),
    id_persona VARCHAR(20),
    FOREIGN KEY (id_persona) REFERENCES persona(No_identidad)
);

CREATE TABLE clases_creadas (
    id_ccreadas INT PRIMARY KEY AUTO_INCREMENT,
    aula VARCHAR(10),
    anio YEAR,
    id_maestro VARCHAR(20),
    FOREIGN KEY (id_maestro) REFERENCES maestro(id_maestro)
);

CREATE TABLE matricula (
    id_matricula INT PRIMARY KEY AUTO_INCREMENT,
    id_alumno VARCHAR(20),
    id_ccreadas INT,
    nota DECIMAL(5,2),
    FOREIGN KEY (id_alumno) REFERENCES alumno(id_alumno),
    FOREIGN KEY (id_ccreadas) REFERENCES clases_creadas(id_ccreadas)
);




CREATE TABLE carrera (
    id_carrera INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL
);

CREATE TABLE clase (
    id_clase INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    horas_por_semana INT NOT NULL,
    descripcion TEXT,
    id_carrera INT NOT NULL,
    FOREIGN KEY (id_carrera) REFERENCES carrera(id_carrera)
);

CREATE TABLE seccion (
    cod_seccion INT PRIMARY KEY AUTO_INCREMENT,
    id_clase INT NOT NULL,
    FOREIGN KEY (id_clase) REFERENCES clase(id_clase)
);


CREATE TABLE clases_creadas (
    id_ccreadas INT PRIMARY KEY AUTO_INCREMENT,
    aula VARCHAR(10),
    anio YEAR,
    id_maestro VARCHAR(20) NOT NULL,
    cod_seccion INT NOT NULL,
    FOREIGN KEY (id_maestro) REFERENCES maestro(id_maestro),
    FOREIGN KEY (cod_seccion) REFERENCES seccion(cod_seccion)
);

ALTER TABLE clases_creadas 
ADD COLUMN cod_seccion INT NOT NULL,
ADD CONSTRAINT fk_cod_seccion FOREIGN KEY (cod_seccion) REFERENCES seccion(cod_seccion);

select * from clases_creadas;

-- TABLA: direccion
INSERT INTO direccion (No_calle, colonia, No_casa) VALUES
('Calle 1', 'Centro', '101'),
('Calle 2', 'Centro', '102'),
('Calle 3', 'Centro', '103'),
('Calle 4', 'Norte', '104'),
('Calle 5', 'Norte', '105'),
('Calle 6', 'Sur', '106'),
('Calle 7', 'Sur', '107'),
('Calle 8', 'Este', '108'),
('Calle 9', 'Oeste', '109'),
('Calle 10', 'Oeste', '110');

SELECT * FROM direccion;

-- TABLA: persona
INSERT INTO persona (No_identidad, nombre, telefono, id_direccion) VALUES
('P001', 'Juan Pérez', '987654321', 1),
('P002', 'Ana Gómez', '987654322', 2),
('P003', 'Carlos Ruiz', '987654323', 3),
('P004', 'Luisa Torres', '987654324', 4),
('P005', 'David Martínez', '987654325', 5),
('P006', 'María Castro', '987654326', 6),
('P007', 'José López', '987654327', 7),
('P008', 'Sofía Rivas', '987654328', 8),
('P009', 'Raúl Herrera', '987654329', 9),
('P010', 'Laura Díaz', '987654330', 10);

SELECT * FROM persona;

-- TABLA: alumno
INSERT INTO alumno (id_alumno, id_persona_responsable) VALUES
('P001', 'P002'),
('P003', 'P004'),
('P005', 'P006'),
('P007', 'P008'),
('P009', 'P010'),
('P002', 'P001'),
('P004', 'P003'),
('P006', 'P005'),
('P008', 'P007'),
('P010', 'P009');

SELECT * FROM alumno;

-- TABLA: empleado
INSERT INTO empleado (id_empleado, no_seguros, sueldo_base, horas_trabajo) VALUES
('P001', 'S001', 12000, 40),
('P002', 'S002', 12500, 40),
('P003', 'S003', 13000, 35),
('P004', 'S004', 11000, 40),
('P005', 'S005', 14000, 30),
('P006', 'S006', 13500, 35),
('P007', 'S007', 12000, 40),
('P008', 'S008', 14500, 30),
('P009', 'S009', 15000, 40),
('P010', 'S010', 16000, 40);

SELECT * FROM empleado;

-- TABLA: EAdministrativo
INSERT INTO EAdministrativo (id_EAdmin, cargo, departamento) VALUES
('P001', 'Secretario', 'Académico'),
('P002', 'Técnico', 'Soporte'),
('P003', 'Asistente', 'Finanzas'),
('P004', 'Oficinista', 'Registro'),
('P005', 'Coordinador', 'Académico'),
('P006', 'Administrador', 'TI'),
('P007', 'Jefe Área', 'Contabilidad'),
('P008', 'Gestor', 'Estudiantil'),
('P009', 'Inspector', 'Disciplinario'),
('P010', 'Analista', 'Planeación');

SELECT * FROM EAdministrativo;

-- TABLA: maestro
INSERT INTO maestro (id_maestro, AreaDocencia) VALUES
('P001', 'Matemáticas'),
('P002', 'Lenguaje'),
('P003', 'Ciencias'),
('P004', 'Historia'),
('P005', 'Inglés'),
('P006', 'Educación Física'),
('P007', 'Arte'),
('P008', 'Biología'),
('P009', 'Física'),
('P010', 'Informática');

SELECT * FROM maestro;

-- TABLA: usuario
INSERT INTO usuario (tipo_usuario, nombre_usuario, pass, id_persona) VALUES
('admin', 'admin1', 'pass1', 'P001'),
('maestro', 'maestro1', 'pass2', 'P002'),
('alumno', 'alumno1', 'pass3', 'P003'),
('alumno', 'alumno2', 'pass4', 'P004'),
('maestro', 'maestro2', 'pass5', 'P005'),
('admin', 'admin2', 'pass6', 'P006'),
('alumno', 'alumno3', 'pass7', 'P007'),
('alumno', 'alumno4', 'pass8', 'P008'),
('maestro', 'maestro3', 'pass9', 'P009'),
('admin', 'admin3', 'pass10', 'P010');

SELECT * FROM usuario;

-- TABLA: carrera
INSERT INTO carrera (nombre) VALUES
('Ingeniería en Sistemas'),
('Administración'),
('Derecho'),
('Psicología'),
('Contaduría'),
('Medicina'),
('Enfermería'),
('Arquitectura'),
('Educación'),
('Diseño Gráfico');

SELECT * FROM carrera;

-- TABLA: clase
INSERT INTO clase (nombre, horas_por_semana, descripcion, id_carrera) VALUES
('Programación I', 4, 'Introducción a la programación', 1),
('Contabilidad', 3, 'Básica', 5),
('Anatomía', 5, 'Cuerpo humano', 6),
('Derecho Penal', 3, 'Leyes penales', 3),
('Psicología General', 4, 'Introducción', 4),
('Diseño Básico', 3, 'Principios del diseño', 10),
('Historia del Arte', 2, 'Arte y cultura', 10),
('Estadística', 3, 'Probabilidades y datos', 2),
('Estructuras', 4, 'Arquitectura', 8),
('Educación Física', 2, 'Salud y deporte', 9);

SELECT * FROM clase;

-- TABLA: seccion
INSERT INTO seccion (id_clase) VALUES
(1),(2),(3),(4),(5),(6),(7),(8),(9),(10);

SELECT * FROM seccion;

-- TABLA: clases_creadas
INSERT INTO clases_creadas (aula, anio, id_maestro, cod_seccion) VALUES
('A101', 2024, 'P001', 1),
('B102', 2024, 'P002', 2),
('C103', 2024, 'P003', 3),
('D104', 2024, 'P004', 4),
('E105', 2024, 'P005', 5),
('F106', 2024, 'P006', 6),
('G107', 2024, 'P007', 7),
('H108', 2024, 'P008', 8),
('I109', 2024, 'P009', 9),
('J110', 2024, 'P010', 10);

SELECT * FROM clases_creadas;

-- TABLA: matricula
INSERT INTO matricula (id_alumno, id_ccreadas, nota) VALUES
('P001', 1, 85.5),
('P003', 2, 90.0),
('P005', 3, 75.0),
('P007', 4, 88.0),
('P009', 5, 92.5),
('P002', 6, 80.0),
('P004', 7, 78.0),
('P006', 8, 95.0),
('P008', 9, 70.0),
('P010', 10, 89.5);

SELECT * FROM matricula;

-- Agregar campo SET a persona
ALTER TABLE persona
ADD COLUMN intereses SET('deportes', 'musica', 'lectura', 'cine', 'viajes');

-- Actualizar con valores de ejemplo
UPDATE persona SET intereses = 'musica,lectura' WHERE No_identidad = 'P001';
UPDATE persona SET intereses = 'cine,viajes' WHERE No_identidad = 'P002';
UPDATE persona SET intereses = 'deportes' WHERE No_identidad = 'P003';
UPDATE persona SET intereses = 'musica,cine' WHERE No_identidad = 'P004';
UPDATE persona SET intereses = 'lectura,viajes' WHERE No_identidad = 'P005';
UPDATE persona SET intereses = 'deportes,lectura' WHERE No_identidad = 'P006';
UPDATE persona SET intereses = 'musica' WHERE No_identidad = 'P007';
UPDATE persona SET intereses = 'cine' WHERE No_identidad = 'P008';
UPDATE persona SET intereses = 'viajes,deportes' WHERE No_identidad = 'P009';
UPDATE persona SET intereses = 'musica,lectura,viajes' WHERE No_identidad = 'P010';

-- Verificar
SELECT No_identidad, nombre, intereses FROM persona;

-- Agregar campo SET a empleado
ALTER TABLE empleado
ADD COLUMN dias_descanso SET('lunes', 'martes', 'miércoles', 'jueves', 'viernes', 'sábado', 'domingo');

-- Actualizar con valores de ejemplo
UPDATE empleado SET dias_descanso = 'domingo' WHERE id_empleado = 'P001';
UPDATE empleado SET dias_descanso = 'sábado,domingo' WHERE id_empleado = 'P002';
UPDATE empleado SET dias_descanso = 'miércoles' WHERE id_empleado = 'P003';
UPDATE empleado SET dias_descanso = 'viernes,domingo' WHERE id_empleado = 'P004';
UPDATE empleado SET dias_descanso = 'sábado' WHERE id_empleado = 'P005';
UPDATE empleado SET dias_descanso = 'lunes' WHERE id_empleado = 'P006';
UPDATE empleado SET dias_descanso = 'lunes,miércoles' WHERE id_empleado = 'P007';
UPDATE empleado SET dias_descanso = 'martes,viernes' WHERE id_empleado = 'P008';
UPDATE empleado SET dias_descanso = 'jueves' WHERE id_empleado = 'P009';
UPDATE empleado SET dias_descanso = 'domingo' WHERE id_empleado = 'P010';

-- Verificar
SELECT id_empleado, dias_descanso FROM empleado;


-- Agregar campo SET a clase
ALTER TABLE clase
ADD COLUMN modalidad SET('presencial', 'virtual', 'híbrida');

-- Actualizar con valores de ejemplo
UPDATE clase SET modalidad = 'presencial' WHERE id_clase = 1;
UPDATE clase SET modalidad = 'virtual' WHERE id_clase = 2;
UPDATE clase SET modalidad = 'híbrida' WHERE id_clase = 3;
UPDATE clase SET modalidad = 'presencial,virtual' WHERE id_clase = 4;
UPDATE clase SET modalidad = 'presencial,híbrida' WHERE id_clase = 5;
UPDATE clase SET modalidad = 'virtual,híbrida' WHERE id_clase = 6;
UPDATE clase SET modalidad = 'presencial' WHERE id_clase = 7;
UPDATE clase SET modalidad = 'virtual' WHERE id_clase = 8;
UPDATE clase SET modalidad = 'presencial' WHERE id_clase = 9;
UPDATE clase SET modalidad = 'híbrida' WHERE id_clase = 10;

-- Verificar
SELECT id_clase, nombre, modalidad FROM clase;


-- a. Modificar tres campos de la tabla clase (ahora será asignatura después del cambio en (e))
UPDATE clase SET nombre = 'Matemática Aplicada', horas_por_semana = 5, descripcion = 'Curso avanzado de matemáticas aplicadas.' WHERE id_clase = 1;
UPDATE clase SET nombre = 'Programación Web', horas_por_semana = 6, descripcion = 'Desarrollo web con HTML, CSS y JS.' WHERE id_clase = 2;
UPDATE clase SET nombre = 'Base de Datos II', horas_por_semana = 4, descripcion = 'Modelado relacional y SQL avanzado.' WHERE id_clase = 3;

-- b. Adicionar un campo Cedula a la tabla alumno
ALTER TABLE alumno
ADD COLUMN cedula VARCHAR(20);

-- c. Adicionar y cambiar el nombre del campo fecha en la tabla alumno
-- Primero renombramos el campo si ya existía como 'fecha'
ALTER TABLE alumno
CHANGE COLUMN fecha fecha_ingreso DATE;

-- Luego agregamos uno nuevo llamado fecha_nacimiento
ALTER TABLE alumno
ADD COLUMN fecha_nacimiento DATE;

-- d. Cambiar el nombre del campo direccion en la tabla direccion
-- Asumiendo que 'id_direccion' es el campo a renombrar tiene error
ALTER TABLE direccion
CHANGE COLUMN id_direccion codigo_direccion INT(20);

select * from direccion
-- e. Cambiar de nombre a dos tablas
-- Renombrar la tabla alumno a estudiante
RENAME TABLE alumno TO estudiante;

-- Renombrar la tabla clase a asignatura
RENAME TABLE clase TO asignatura;
















