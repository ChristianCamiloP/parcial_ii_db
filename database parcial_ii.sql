
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

