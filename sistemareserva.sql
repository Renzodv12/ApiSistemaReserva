-- Database: sistema_reservas

-- DROP DATABASE IF EXISTS sistema_reservas;

CREATE DATABASE sistema_reservas
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'en_US.utf8'
    LC_CTYPE = 'en_US.utf8'
    LOCALE_PROVIDER = 'libc'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;


-- Tabla USUARIOS
CREATE TABLE USUARIOS (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    contraseña VARCHAR(100) NOT NULL,
    fecha_registro DATE DEFAULT CURRENT_DATE,
    activo BOOLEAN DEFAULT TRUE
);

-- Tabla DEPORTES
CREATE TABLE DEPORTES (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    descripcion TEXT
);

-- Tabla LOCALIDADES
CREATE TABLE LOCALIDADES (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    direccion VARCHAR(200),
    codigo_postal VARCHAR(10)
);

-- Tabla CANCHAS
CREATE TABLE CANCHAS (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    capacidad INT,
    precio_por_hora DECIMAL(10, 2) NOT NULL,
    id_deporte INT REFERENCES DEPORTES(id),
    id_localidad INT REFERENCES LOCALIDADES(id)
);

-- Tabla RESERVAS
CREATE TABLE RESERVAS (
    id SERIAL PRIMARY KEY,
    id_usuario INT REFERENCES USUARIOS(id),
    id_cancha INT REFERENCES CANCHAS(id),
    fecha_hora_inicio TIMESTAMP NOT NULL,
    fecha_hora_fin TIMESTAMP NOT NULL,
    precio_total DECIMAL(10, 2) NOT NULL,
    estado VARCHAR(50) NOT NULL
);

-- Tabla RECOMENDACIONES
CREATE TABLE RECOMENDACIONES (
    id SERIAL PRIMARY KEY,
    id_usuario INT REFERENCES USUARIOS(id),
    id_cancha INT REFERENCES CANCHAS(id),
    tipo_recomendacion VARCHAR(50) NOT NULL,
    prioridad INT DEFAULT 1,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);












-- Inserts para USUARIOS
INSERT INTO USUARIOS (nombre, apellido, email, contraseña) VALUES ('Juan', 'Pérez', 'juan.perez1@email.com', 'pass123');
INSERT INTO USUARIOS (nombre, apellido, email, contraseña) VALUES ('María', 'García', 'maria.garcia2@email.com', 'pass234');
INSERT INTO USUARIOS (nombre, apellido, email, contraseña) VALUES ('Pedro', 'López', 'pedro.lopez3@email.com', 'pass345');
INSERT INTO USUARIOS (nombre, apellido, email, contraseña) VALUES ('Ana', 'Martínez', 'ana.martinez4@email.com', 'pass456');
INSERT INTO USUARIOS (nombre, apellido, email, contraseña) VALUES ('Carlos', 'Rodríguez', 'carlos.rodriguez5@email.com', 'pass567');
INSERT INTO USUARIOS (nombre, apellido, email, contraseña) VALUES ('Laura', 'Sánchez', 'laura.sanchez6@email.com', 'pass678');
INSERT INTO USUARIOS (nombre, apellido, email, contraseña) VALUES ('Diego', 'González', 'diego.gonzalez7@email.com', 'pass789');
INSERT INTO USUARIOS (nombre, apellido, email, contraseña) VALUES ('Sofia', 'Fernández', 'sofia.fernandez8@email.com', 'pass890');
INSERT INTO USUARIOS (nombre, apellido, email, contraseña) VALUES ('Miguel', 'Torres', 'miguel.torres9@email.com', 'pass901');
INSERT INTO USUARIOS (nombre, apellido, email, contraseña) VALUES ('Elena', 'Díaz', 'elena.diaz10@email.com', 'pass012');
INSERT INTO USUARIOS (nombre, apellido, email, contraseña) VALUES ('Ricardo', 'Ruiz', 'ricardo.ruiz11@email.com', 'pass123');
INSERT INTO USUARIOS (nombre, apellido, email, contraseña) VALUES ('Carmen', 'Morales', 'carmen.morales12@email.com', 'pass234');
INSERT INTO USUARIOS (nombre, apellido, email, contraseña) VALUES ('José', 'Jiménez', 'jose.jimenez13@email.com', 'pass345');
INSERT INTO USUARIOS (nombre, apellido, email, contraseña) VALUES ('Isabel', 'Romero', 'isabel.romero14@email.com', 'pass456');
INSERT INTO USUARIOS (nombre, apellido, email, contraseña) VALUES ('Roberto', 'Navarro', 'roberto.navarro15@email.com', 'pass567');
INSERT INTO USUARIOS (nombre, apellido, email, contraseña) VALUES ('Patricia', 'Muñoz', 'patricia.munoz16@email.com', 'pass678');
INSERT INTO USUARIOS (nombre, apellido, email, contraseña) VALUES ('Fernando', 'Alonso', 'fernando.alonso17@email.com', 'pass789');
INSERT INTO USUARIOS (nombre, apellido, email, contraseña) VALUES ('Lucía', 'Gil', 'lucia.gil18@email.com', 'pass890');
INSERT INTO USUARIOS (nombre, apellido, email, contraseña) VALUES ('Alberto', 'Vázquez', 'alberto.vazquez19@email.com', 'pass901');
INSERT INTO USUARIOS (nombre, apellido, email, contraseña) VALUES ('Cristina', 'Castro', 'cristina.castro20@email.com', 'pass012');

-- Inserts para DEPORTES
INSERT INTO DEPORTES (nombre, descripcion) VALUES ('Fútbol', 'Deporte de equipo con balón');
INSERT INTO DEPORTES (nombre, descripcion) VALUES ('Básquetbol', 'Deporte de equipo con pelota y cestas');
INSERT INTO DEPORTES (nombre, descripcion) VALUES ('Tenis', 'Deporte de raqueta');
INSERT INTO DEPORTES (nombre, descripcion) VALUES ('Vóley', 'Deporte de equipo con red');
INSERT INTO DEPORTES (nombre, descripcion) VALUES ('Pádel', 'Deporte de raqueta en cancha cerrada');

-- Inserts para LOCALIDADES
INSERT INTO LOCALIDADES (nombre, direccion, codigo_postal) VALUES ('Centro Deportivo Norte', 'Av. Principal 123', '28001');
INSERT INTO LOCALIDADES (nombre, direccion, codigo_postal) VALUES ('Complejo Sur', 'Calle Secundaria 456', '28002');
INSERT INTO LOCALIDADES (nombre, direccion, codigo_postal) VALUES ('Club Este', 'Plaza Mayor 789', '28003');
INSERT INTO LOCALIDADES (nombre, direccion, codigo_postal) VALUES ('Polideportivo Oeste', 'Av. Libertad 321', '28004');
INSERT INTO LOCALIDADES (nombre, direccion, codigo_postal) VALUES ('Centro Municipal', 'Calle Central 654', '28005');

-- Inserts para CANCHAS
INSERT INTO CANCHAS (nombre, capacidad, precio_por_hora, id_deporte, id_localidad) VALUES ('Cancha F1', 22, 100.00, 1, 1);
INSERT INTO CANCHAS (nombre, capacidad, precio_por_hora, id_deporte, id_localidad) VALUES ('Cancha F2', 22, 120.00, 1, 1);
INSERT INTO CANCHAS (nombre, capacidad, precio_por_hora, id_deporte, id_localidad) VALUES ('Cancha B1', 10, 80.00, 2, 1);
INSERT INTO CANCHAS (nombre, capacidad, precio_por_hora, id_deporte, id_localidad) VALUES ('Cancha T1', 4, 60.00, 3, 2);
INSERT INTO CANCHAS (nombre, capacidad, precio_por_hora, id_deporte, id_localidad) VALUES ('Cancha V1', 12, 70.00, 4, 2);
INSERT INTO CANCHAS (nombre, capacidad, precio_por_hora, id_deporte, id_localidad) VALUES ('Cancha P1', 4, 90.00, 5, 3);
INSERT INTO CANCHAS (nombre, capacidad, precio_por_hora, id_deporte, id_localidad) VALUES ('Cancha F3', 22, 110.00, 1, 3);
INSERT INTO CANCHAS (nombre, capacidad, precio_por_hora, id_deporte, id_localidad) VALUES ('Cancha B2', 10, 85.00, 2, 4);
INSERT INTO CANCHAS (nombre, capacidad, precio_por_hora, id_deporte, id_localidad) VALUES ('Cancha T2', 4, 65.00, 3, 4);
INSERT INTO CANCHAS (nombre, capacidad, precio_por_hora, id_deporte, id_localidad) VALUES ('Cancha V2', 12, 75.00, 4, 5);

-- Inserts para RESERVAS
INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (1, 1, '2024-11-10 10:00', '2024-11-10 11:00', 100.00, 'Confirmada');
INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (2, 2, '2024-11-10 11:00', '2024-11-10 12:00', 120.00, 'Confirmada');
INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (3, 3, '2024-11-10 12:00', '2024-11-10 13:00', 80.00, 'Pendiente');
INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (4, 4, '2024-11-10 13:00', '2024-11-10 14:00', 60.00, 'Confirmada');
INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (5, 5, '2024-11-10 14:00', '2024-11-10 15:00', 70.00, 'Cancelada');
INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (6, 6, '2024-11-10 15:00', '2024-11-10 16:00', 90.00, 'Confirmada');
INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (7, 7, '2024-11-10 16:00', '2024-11-10 17:00', 110.00, 'Pendiente');
INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (8, 8, '2024-11-10 17:00', '2024-11-10 18:00', 85.00, 'Confirmada');
INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (9, 9, '2024-11-10 18:00', '2024-11-10 19:00', 65.00, 'Confirmada');
INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (10, 10, '2024-11-10 19:00', '2024-11-10 20:00', 75.00, 'Pendiente');

-- Inserts para RECOMENDACIONES
INSERT INTO RECOMENDACIONES (id_usuario, id_cancha, tipo_recomendacion, prioridad) VALUES (1, 1, 'Favorito', 1);
INSERT INTO RECOMENDACIONES (id_usuario, id_cancha, tipo_recomendacion, prioridad) VALUES (2, 2, 'Sugerido', 2);
INSERT INTO RECOMENDACIONES (id_usuario, id_cancha, tipo_recomendacion, prioridad) VALUES (3, 3, 'Favorito', 1);
INSERT INTO RECOMENDACIONES (id_usuario, id_cancha, tipo_recomendacion, prioridad) VALUES (4, 4, 'Sugerido', 3);
INSERT INTO RECOMENDACIONES (id_usuario, id_cancha, tipo_recomendacion, prioridad) VALUES (5, 5, 'Favorito', 1);
INSERT INTO RECOMENDACIONES (id_usuario, id_cancha, tipo_recomendacion, prioridad) VALUES (6, 6, 'Sugerido', 2);
INSERT INTO RECOMENDACIONES (id_usuario, id_cancha, tipo_recomendacion, prioridad) VALUES (7, 7, 'Favorito', 1);
INSERT INTO RECOMENDACIONES (id_usuario, id_cancha, tipo_recomendacion, prioridad) VALUES (8, 8, 'Sugerido', 3);
INSERT INTO RECOMENDACIONES (id_usuario, id_cancha, tipo_recomendacion, prioridad) VALUES (9, 9, 'Favorito', 1);
INSERT INTO RECOMENDACIONES (id_usuario, id_cancha, tipo_recomendacion, prioridad) VALUES (10, 10, 'Sugerido', 2);



	-- 100 Inserts adicionales para RESERVAS
INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (1, 2, '2024-11-11 10:00', '2024-11-11 11:00', 120.00, 'Confirmada');
INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (3, 4, '2024-11-11 11:00', '2024-11-11 12:00', 60.00, 'Pendiente');
INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (5, 6, '2024-11-11 12:00', '2024-11-11 13:00', 90.00, 'Confirmada');
INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (7, 8, '2024-11-11 13:00', '2024-11-11 14:00', 85.00, 'Cancelada');
INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (9, 10, '2024-11-11 14:00', '2024-11-11 15:00', 75.00, 'Confirmada');
INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (2, 1, '2024-11-11 15:00', '2024-11-11 16:00', 100.00, 'Pendiente');
INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (4, 3, '2024-11-11 16:00', '2024-11-11 17:00', 80.00, 'Confirmada');
INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (6, 5, '2024-11-11 17:00', '2024-11-11 18:00', 70.00, 'Confirmada');
INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (8, 7, '2024-11-11 18:00', '2024-11-11 19:00', 110.00, 'Cancelada');
INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (10, 9, '2024-11-11 19:00', '2024-11-11 20:00', 65.00, 'Confirmada');

INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (1, 3, '2024-11-12 10:00', '2024-11-12 11:00', 80.00, 'Confirmada');
INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (2, 4, '2024-11-12 11:00', '2024-11-12 12:00', 60.00, 'Pendiente');
INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (3, 5, '2024-11-12 12:00', '2024-11-12 13:00', 70.00, 'Confirmada');
INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (4, 6, '2024-11-12 13:00', '2024-11-12 14:00', 90.00, 'Confirmada');
INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (5, 7, '2024-11-12 14:00', '2024-11-12 15:00', 110.00, 'Cancelada');
INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (6, 8, '2024-11-12 15:00', '2024-11-12 16:00', 85.00, 'Confirmada');
INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (7, 9, '2024-11-12 16:00', '2024-11-12 17:00', 65.00, 'Pendiente');
INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (8, 10, '2024-11-12 17:00', '2024-11-12 18:00', 75.00, 'Confirmada');
INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (9, 1, '2024-11-12 18:00', '2024-11-12 19:00', 100.00, 'Confirmada');
INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (10, 2, '2024-11-12 19:00', '2024-11-12 20:00', 120.00, 'Cancelada');

INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (11, 1, '2024-11-13 10:00', '2024-11-13 11:00', 100.00, 'Confirmada');
INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (12, 2, '2024-11-13 11:00', '2024-11-13 12:00', 120.00, 'Pendiente');
INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (13, 3, '2024-11-13 12:00', '2024-11-13 13:00', 80.00, 'Confirmada');
INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (14, 4, '2024-11-13 13:00', '2024-11-13 14:00', 60.00, 'Confirmada');
INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (15, 5, '2024-11-13 14:00', '2024-11-13 15:00', 70.00, 'Cancelada');
INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (16, 6, '2024-11-13 15:00', '2024-11-13 16:00', 90.00, 'Confirmada');
INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (17, 7, '2024-11-13 16:00', '2024-11-13 17:00', 110.00, 'Pendiente');
INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (18, 8, '2024-11-13 17:00', '2024-11-13 18:00', 85.00, 'Confirmada');
INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (19, 9, '2024-11-13 18:00', '2024-11-13 19:00', 65.00, 'Confirmada');
INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (20, 10, '2024-11-13 19:00', '2024-11-13 20:00', 75.00, 'Cancelada');

INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (1, 4, '2024-11-14 10:00', '2024-11-14 11:00', 60.00, 'Confirmada');
INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (2, 5, '2024-11-14 11:00', '2024-11-14 12:00', 70.00, 'Pendiente');
INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (3, 6, '2024-11-14 12:00', '2024-11-14 13:00', 90.00, 'Confirmada');
INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (4, 7, '2024-11-14 13:00', '2024-11-14 14:00', 110.00, 'Confirmada');
INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (5, 8, '2024-11-14 14:00', '2024-11-14 15:00', 85.00, 'Cancelada');
INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (6, 9, '2024-11-14 15:00', '2024-11-14 16:00', 65.00, 'Confirmada');
INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (7, 10, '2024-11-14 16:00', '2024-11-14 17:00', 75.00, 'Pendiente');
INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (8, 1, '2024-11-14 17:00', '2024-11-14 18:00', 100.00, 'Confirmada');
INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (9, 2, '2024-11-14 18:00', '2024-11-14 19:00', 120.00, 'Confirmada');
INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (10, 3, '2024-11-14 19:00', '2024-11-14 20:00', 80.00, 'Cancelada');

INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (11, 5, '2024-11-15 10:00', '2024-11-15 11:00', 70.00, 'Confirmada');
INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (12, 6, '2024-11-15 11:00', '2024-11-15 12:00', 90.00, 'Pendiente');
INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (13, 7, '2024-11-15 12:00', '2024-11-15 13:00', 110.00, 'Confirmada');
INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (14, 8, '2024-11-15 13:00', '2024-11-15 14:00', 85.00, 'Confirmada');
INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (15, 9, '2024-11-15 14:00', '2024-11-15 15:00', 65.00, 'Cancelada');
INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (16, 10, '2024-11-15 15:00', '2024-11-15 16:00', 75.00, 'Confirmada');
INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (17, 1, '2024-11-15 16:00', '2024-11-15 17:00', 100.00, 'Pendiente');
INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (18, 2, '2024-11-15 17:00', '2024-11-15 18:00', 120.00, 'Confirmada');
INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (19, 3, '2024-11-15 18:00', '2024-11-15 19:00', 80.00, 'Confirmada');
INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (20, 4, '2024-11-15 19:00', '2024-11-15 20:00', 60.00, 'Cancelada');

INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (1, 6, '2024-11-16 10:00', '2024-11-16 11:00', 90.00, 'Confirmada');
INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (2, 7, '2024-11-16 11:00', '2024-11-16 12:00', 110.00, 'Pendiente');




CREATE TABLE horario (
    id SERIAL PRIMARY KEY,
    canchaid INTEGER NOT NULL,
    fecha DATE NOT NULL,
    horainicio TIME NOT NULL,
    horafin TIME NOT NULL,
    CONSTRAINT fk_horario_cancha FOREIGN KEY (canchaid) REFERENCES canchas(id)
);
INSERT INTO Horario (CanchaId, Fecha, HoraInicio, HoraFin) VALUES (1, '2024-11-16', '08:00:00', '09:00:00');
INSERT INTO Horario (CanchaId, Fecha, HoraInicio, HoraFin) VALUES (1, '2024-11-16', '09:00:00', '10:00:00');
INSERT INTO Horario (CanchaId, Fecha, HoraInicio, HoraFin) VALUES (1, '2024-11-16', '10:00:00', '11:00:00');
INSERT INTO Horario (CanchaId, Fecha, HoraInicio, HoraFin) VALUES (2, '2024-11-16', '08:00:00', '09:00:00');
INSERT INTO Horario (CanchaId, Fecha, HoraInicio, HoraFin) VALUES (2, '2024-11-16', '09:00:00', '10:00:00');
INSERT INTO Horario (CanchaId, Fecha, HoraInicio, HoraFin) VALUES (2, '2024-11-16', '10:00:00', '11:00:00');
INSERT INTO Horario (CanchaId, Fecha, HoraInicio, HoraFin) VALUES (3, '2024-11-16', '08:00:00', '09:00:00');
INSERT INTO Horario (CanchaId, Fecha, HoraInicio, HoraFin) VALUES (3, '2024-11-16', '09:00:00', '10:00:00');
INSERT INTO Horario (CanchaId, Fecha, HoraInicio, HoraFin) VALUES (3, '2024-11-16', '10:00:00', '11:00:00');
INSERT INTO Horario (CanchaId, Fecha, HoraInicio, HoraFin) VALUES (4, '2024-11-16', '08:00:00', '09:00:00');
INSERT INTO Horario (CanchaId, Fecha, HoraInicio, HoraFin) VALUES (4, '2024-11-16', '09:00:00', '10:00:00');
INSERT INTO Horario (CanchaId, Fecha, HoraInicio, HoraFin) VALUES (4, '2024-11-16', '10:00:00', '11:00:00');
INSERT INTO Horario (CanchaId, Fecha, HoraInicio, HoraFin) VALUES (5, '2024-11-16', '08:00:00', '09:00:00');
INSERT INTO Horario (CanchaId, Fecha, HoraInicio, HoraFin) VALUES (5, '2024-11-16', '09:00:00', '10:00:00');
INSERT INTO Horario (CanchaId, Fecha, HoraInicio, HoraFin) VALUES (5, '2024-11-16', '10:00:00', '11:00:00');
INSERT INTO Horario (CanchaId, Fecha, HoraInicio, HoraFin) VALUES (6, '2024-11-16', '08:00:00', '09:00:00');
INSERT INTO Horario (CanchaId, Fecha, HoraInicio, HoraFin) VALUES (6, '2024-11-16', '09:00:00', '10:00:00');
INSERT INTO Horario (CanchaId, Fecha, HoraInicio, HoraFin) VALUES (6, '2024-11-16', '10:00:00', '11:00:00');
INSERT INTO Horario (CanchaId, Fecha, HoraInicio, HoraFin) VALUES (7, '2024-11-16', '08:00:00', '09:00:00');
INSERT INTO Horario (CanchaId, Fecha, HoraInicio, HoraFin) VALUES (7, '2024-11-16', '09:00:00', '10:00:00');




INSERT INTO USUARIOS (nombre, apellido, email, contraseña) VALUES ('Juan', 'Pérez', 'juan.perez@email.com', 'pass1234');
INSERT INTO USUARIOS (nombre, apellido, email, contraseña) VALUES ('Laura', 'Gómez', 'laura.gomez@email.com', 'secure789');
INSERT INTO USUARIOS (nombre, apellido, email, contraseña) VALUES ('Ana', 'López', 'ana.lopez@email.com', 'mypassword01');
INSERT INTO USUARIOS (nombre, apellido, email, contraseña) VALUES ('Carlos', 'Martínez', 'carlos.martinez@email.com', 'password789');
INSERT INTO USUARIOS (nombre, apellido, email, contraseña) VALUES ('María', 'Ramírez', 'maria.ramirez@email.com', 'pass456');
INSERT INTO USUARIOS (nombre, apellido, email, contraseña) VALUES ('Luis', 'Sánchez', 'luis.sanchez@email.com', 'pass321');
INSERT INTO USUARIOS (nombre, apellido, email, contraseña) VALUES ('Daniela', 'Torres', 'daniela.torres@email.com', 'mypassword11');
INSERT INTO USUARIOS (nombre, apellido, email, contraseña) VALUES ('Jorge', 'Rodríguez', 'jorge.rodriguez@email.com', 'securepass');
INSERT INTO USUARIOS (nombre, apellido, email, contraseña) VALUES ('Andrea', 'Hernández', 'andrea.hernandez@email.com', 'password99');
INSERT INTO USUARIOS (nombre, apellido, email, contraseña) VALUES ('Sofía', 'Morales', 'sofia.morales@email.com', 'pass7890');
INSERT INTO USUARIOS (nombre, apellido, email, contraseña) VALUES ('Felipe', 'Vargas', 'felipe.vargas@email.com', 'my_pass01');
INSERT INTO USUARIOS (nombre, apellido, email, contraseña) VALUES ('Camila', 'Fernández', 'camila.fernandez@email.com', 'qwerty123');
INSERT INTO USUARIOS (nombre, apellido, email, contraseña) VALUES ('Alejandro', 'Díaz', 'alejandro.diaz@email.com', 'passme88');
INSERT INTO USUARIOS (nombre, apellido, email, contraseña) VALUES ('Paola', 'Castillo', 'paola.castillo@email.com', 'letmein99');
INSERT INTO USUARIOS (nombre, apellido, email, contraseña) VALUES ('Miguel', 'Ortiz', 'miguel.ortiz@email.com', 'mypwd201');
INSERT INTO USUARIOS (nombre, apellido, email, contraseña) VALUES ('Verónica', 'Rojas', 'veronica.rojas@email.com', 'password78');
INSERT INTO USUARIOS (nombre, apellido, email, contraseña) VALUES ('Oscar', 'Jiménez', 'oscar.jimenez@email.com', 'pass135');
INSERT INTO USUARIOS (nombre, apellido, email, contraseña) VALUES ('Adriana', 'Ruiz', 'adriana.ruiz@email.com', 'mypass99');
INSERT INTO USUARIOS (nombre, apellido, email, contraseña) VALUES ('Iván', 'Flores', 'ivan.flores@email.com', 'pw_987');
INSERT INTO USUARIOS (nombre, apellido, email, contraseña) VALUES ('Gabriela', 'Medina', 'gabriela.medina@email.com', '1234abcd');
INSERT INTO USUARIOS (nombre, apellido, email, contraseña) VALUES ('Ricardo', 'Cruz', 'ricardo.cruz@email.com', 'safepass');
INSERT INTO USUARIOS (nombre, apellido, email, contraseña) VALUES ('Elena', 'Mendoza', 'elena.mendoza@email.com', 'securepass23');
INSERT INTO USUARIOS (nombre, apellido, email, contraseña) VALUES ('Victor', 'Ibarra', 'victor.ibarra@email.com', 'mypassword77');
INSERT INTO USUARIOS (nombre, apellido, email, contraseña) VALUES ('Patricia', 'Campos', 'patricia.campos@email.com', 'mypass77');
INSERT INTO USUARIOS (nombre, apellido, email, contraseña) VALUES ('Javier', 'Carrillo', 'javier.carrillo@email.com', 'pass_secure');
INSERT INTO USUARIOS (nombre, apellido, email, contraseña) VALUES ('Daniel', 'Silva', 'daniel.silva@email.com', 'password111');
INSERT INTO USUARIOS (nombre, apellido, email, contraseña) VALUES ('Lucía', 'Guerrero', 'lucia.guerrero@email.com', 'p@ssword88');
INSERT INTO USUARIOS (nombre, apellido, email, contraseña) VALUES ('Raúl', 'Navarro', 'raul.navarro@email.com', 'passwordXY');
INSERT INTO USUARIOS (nombre, apellido, email, contraseña) VALUES ('Marta', 'Delgado', 'marta.delgado@email.com', 'passwd22');
INSERT INTO USUARIOS (nombre, apellido, email, contraseña) VALUES ('Isabel', 'Nuñez', 'isabel.nunez@email.com', 'pass2468');
INSERT INTO USUARIOS (nombre, apellido, email, contraseña) VALUES ('Rodrigo', 'Peña', 'rodrigo.pena@email.com', '1234password');
INSERT INTO USUARIOS (nombre, apellido, email, contraseña) VALUES ('Esteban', 'Luna', 'esteban.luna@email.com', 'myPass_2024');
INSERT INTO USUARIOS (nombre, apellido, email, contraseña) VALUES ('Lorena', 'Reyes', 'lorena.reyes@email.com', 'securePass_9');
INSERT INTO USUARIOS (nombre, apellido, email, contraseña) VALUES ('Marcos', 'Santana', 'marcos.santana@email.com', 'mypass_123');
INSERT INTO USUARIOS (nombre, apellido, email, contraseña) VALUES ('Teresa', 'Vega', 'teresa.vega@email.com', 'pw9876');
INSERT INTO USUARIOS (nombre, apellido, email, contraseña) VALUES ('Alberto', 'Suárez', 'alberto.suarez@email.com', 'letmein456');
INSERT INTO USUARIOS (nombre, apellido, email, contraseña) VALUES ('Renata', 'Aguilar', 'renata.aguilar@email.com', 'pass2000');
INSERT INTO USUARIOS (nombre, apellido, email, contraseña) VALUES ('Enrique', 'Paredes', 'enrique.paredes@email.com', 'passW123!');
INSERT INTO USUARIOS (nombre, apellido, email, contraseña) VALUES ('Carmen', 'Cortés', 'carmen.cortes@email.com', 'newpass99');
INSERT INTO USUARIOS (nombre, apellido, email, contraseña) VALUES ('Nicolás', 'Ortega', 'nicolas.ortega@email.com', 'mypassword42');
INSERT INTO USUARIOS (nombre, apellido, email, contraseña) VALUES ('Angela', 'Fuentes', 'angela.fuentes@email.com', 'passW_2024');
INSERT INTO USUARIOS (nombre, apellido, email, contraseña) VALUES ('Gonzalo', 'Salinas', 'gonzalo.salinas@email.com', 'qwerty567');
INSERT INTO USUARIOS (nombre, apellido, email, contraseña) VALUES ('Silvia', 'Campos', 'silvia.campos@email.com', 'passwordXYZ');
INSERT INTO USUARIOS (nombre, apellido, email, contraseña) VALUES ('Tomás', 'Padilla', 'tomas.padilla@email.com', 'safePass321');




INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (5, 3, '2024-11-14 16:00', '2024-11-14 17:00', 50.00, 'Confirmada');
INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (7, 2, '2024-11-14 10:00', '2024-11-14 11:00', 45.00, 'Pendiente');
INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (12, 5, '2024-11-15 14:00', '2024-11-15 15:00', 60.00, 'Cancelada');
INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (20, 7, '2024-11-15 18:00', '2024-11-15 19:00', 75.00, 'Confirmada');
INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (3, 1, '2024-11-16 12:00', '2024-11-16 13:00', 40.00, 'Confirmada');
INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (15, 6, '2024-11-16 09:00', '2024-11-16 10:00', 55.00, 'Pendiente');
INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (8, 4, '2024-11-17 15:00', '2024-11-17 16:00', 65.00, 'Confirmada');
INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (6, 2, '2024-11-17 19:00', '2024-11-17 20:00', 70.00, 'Cancelada');
INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (11, 9, '2024-11-18 08:00', '2024-11-18 09:00', 80.00, 'Confirmada');
INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (17, 5, '2024-11-18 20:00', '2024-11-18 21:00', 90.00, 'Pendiente');
INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (4, 6, '2024-11-14 10:00', '2024-11-14 11:00', 50.00, 'Pendiente');
INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (9, 8, '2024-11-14 12:00', '2024-11-14 13:00', 65.00, 'Confirmada');
INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (10, 4, '2024-11-14 14:00', '2024-11-14 15:00', 55.00, 'Cancelada');
INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (13, 3, '2024-11-14 16:00', '2024-11-14 17:00', 45.00, 'Confirmada');
INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (14, 2, '2024-11-14 18:00', '2024-11-14 19:00', 70.00, 'Pendiente');
INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (16, 7, '2024-11-15 08:00', '2024-11-15 09:00', 75.00, 'Confirmada');
INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (18, 1, '2024-11-15 11:00', '2024-11-15 12:00', 60.00, 'Cancelada');
INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (19, 5, '2024-11-15 14:00', '2024-11-15 15:00', 80.00, 'Confirmada');
INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (21, 9, '2024-11-15 16:00', '2024-11-15 17:00', 85.00, 'Pendiente');

INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (3, 6, '2024-11-16 09:00', '2024-11-16 10:00', 55.00, 'Pendiente');
INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (5, 7, '2024-11-16 11:00', '2024-11-16 12:00', 65.00, 'Confirmada');
INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (6, 2, '2024-11-16 13:00', '2024-11-16 14:00', 45.00, 'Cancelada');
INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (7, 1, '2024-11-16 15:00', '2024-11-16 16:00', 60.00, 'Confirmada');
INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (11, 4, '2024-11-16 17:00', '2024-11-16 18:00', 75.00, 'Pendiente');
INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (12, 3, '2024-11-16 19:00', '2024-11-16 20:00', 85.00, 'Confirmada');
INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (14, 5, '2024-11-16 21:00', '2024-11-16 22:00', 90.00, 'Cancelada');
INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (15, 8, '2024-11-17 08:00', '2024-11-17 09:00', 70.00, 'Confirmada');
INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (17, 9, '2024-11-17 10:00', '2024-11-17 11:00', 60.00, 'Pendiente');
INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (20, 6, '2024-11-17 12:00', '2024-11-17 13:00', 65.00, 'Confirmada');

INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (23, 2, '2024-11-18 09:00', '2024-11-18 10:00', 50.00, 'Confirmada');
INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (25, 7, '2024-11-18 11:00', '2024-11-18 12:00', 80.00, 'Pendiente');
INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (26, 4, '2024-11-18 13:00', '2024-11-18 14:00', 90.00, 'Cancelada');
INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (28, 3, '2024-11-18 15:00', '2024-11-18 16:00', 85.00, 'Confirmada');
INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (29, 1, '2024-11-18 17:00', '2024-11-18 18:00', 60.00, 'Pendiente');
INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (30, 5, '2024-11-18 19:00', '2024-11-18 20:00', 55.00, 'Confirmada');
INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (31, 9, '2024-11-18 21:00', '2024-11-18 22:00', 75.00, 'Cancelada');
INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (32, 8, '2024-11-19 08:00', '2024-11-19 09:00', 65.00, 'Confirmada');
INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (33, 6, '2024-11-19 10:00', '2024-11-19 11:00', 70.00, 'Pendiente');
INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (35, 4, '2024-11-19 14:00', '2024-11-19 15:00', 60.00, 'Confirmada');
INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (36, 7, '2024-11-19 16:00', '2024-11-19 17:00', 55.00, 'Pendiente');
INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (37, 1, '2024-11-19 18:00', '2024-11-19 19:00', 80.00, 'Cancelada');
INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (38, 5, '2024-11-20 08:00', '2024-11-20 09:00', 65.00, 'Confirmada');
INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (39, 3, '2024-11-20 10:00', '2024-11-20 11:00', 90.00, 'Pendiente');
INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (40, 8, '2024-11-20 12:00', '2024-11-20 13:00', 75.00, 'Confirmada');
INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (41, 2, '2024-11-20 14:00', '2024-11-20 15:00', 85.00, 'Cancelada');
INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (42, 9, '2024-11-20 16:00', '2024-11-20 17:00', 70.00, 'Confirmada');
INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (43, 4, '2024-11-20 18:00', '2024-11-20 19:00', 60.00, 'Pendiente');
INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (44, 6, '2024-11-21 08:00', '2024-11-21 09:00', 95.00, 'Confirmada');

INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (45, 3, '2024-11-21 10:00', '2024-11-21 11:00', 50.00, 'Pendiente');
INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (46, 5, '2024-11-21 12:00', '2024-11-21 13:00', 85.00, 'Confirmada');
INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (47, 8, '2024-11-21 14:00', '2024-11-21 15:00', 75.00, 'Cancelada');
INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (48, 7, '2024-11-21 16:00', '2024-11-21 17:00', 55.00, 'Confirmada');
INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (49, 1, '2024-11-21 18:00', '2024-11-21 19:00', 65.00, 'Pendiente');
INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (50, 2, '2024-11-22 08:00', '2024-11-22 09:00', 60.00, 'Confirmada');
INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (51, 4, '2024-11-22 10:00', '2024-11-22 11:00', 95.00, 'Cancelada');
INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (52, 6, '2024-11-22 12:00', '2024-11-22 13:00', 50.00, 'Confirmada');
INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (53, 3, '2024-11-22 14:00', '2024-11-22 15:00', 75.00, 'Pendiente');
INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (54, 9, '2024-11-22 16:00', '2024-11-22 17:00', 85.00, 'Confirmada');

INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (55, 8, '2024-11-23 08:00', '2024-11-23 09:00', 65.00, 'Cancelada');
INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (56, 7, '2024-11-23 10:00', '2024-11-23 11:00', 55.00, 'Confirmada');
INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (57, 1, '2024-11-23 12:00', '2024-11-23 13:00', 70.00, 'Pendiente');
INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (58, 5, '2024-11-23 14:00', '2024-11-23 15:00', 75.00, 'Confirmada');
INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (59, 4, '2024-11-23 16:00', '2024-11-23 17:00', 60.00, 'Cancelada');
INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (60, 6, '2024-11-23 18:00', '2024-11-23 19:00', 80.00, 'Confirmada');
INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (61, 3, '2024-11-24 08:00', '2024-11-24 09:00', 90.00, 'Pendiente');
INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (62, 2, '2024-11-24 10:00', '2024-11-24 11:00', 85.00, 'Confirmada');
INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (63, 9, '2024-11-24 12:00', '2024-11-24 13:00', 95.00, 'Cancelada');
INSERT INTO RESERVAS (id_usuario, id_cancha, fecha_hora_inicio, fecha_hora_fin, precio_total, estado) VALUES (64, 8, '2024-11-24 14:00', '2024-11-24 15:00', 50.00, 'Confirmada');