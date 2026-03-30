-- ================================================================
--  SISTEMA DE GESTIÓN DE VENTAS — "COMERCIO YA"
--  Script completo — Módulo 7
-- ================================================================

-- ================================================================
--  LECCIÓN 2: Tabla Clientes
-- ================================================================

CREATE TABLE Clientes (
    id_cliente      INTEGER  PRIMARY KEY AUTOINCREMENT,
    rut             TEXT     NOT NULL UNIQUE,
    nombre          TEXT     NOT NULL,
    email           TEXT     NOT NULL UNIQUE,
    telefono        TEXT,
    ciudad          TEXT     NOT NULL,
    fecha_registro  TEXT     NOT NULL DEFAULT (DATE('now'))
);

INSERT INTO Clientes (rut, nombre, email, telefono, ciudad, fecha_registro)
VALUES ('12.345.678-9', 'Ana García', 'ana.garcia@mail.com', '912345678', 'Santiago', '2024-01-10');

INSERT INTO Clientes (rut, nombre, email, telefono, ciudad, fecha_registro)
VALUES ('15.678.432-3', 'Carlos López', 'carlos.lopez@mail.com', '923456789', 'Valparaíso', '2024-01-15');

INSERT INTO Clientes (rut, nombre, email, telefono, ciudad, fecha_registro)
VALUES ('18.234.567-K', 'María Martínez', 'maria.m@mail.com', '934567890', 'Concepción', '2024-02-01');

INSERT INTO Clientes (rut, nombre, email, telefono, ciudad, fecha_registro)
VALUES ('11.987.654-2', 'Luis Fernández', 'luis.f@mail.com', '945678901', 'Santiago', '2024-02-10');

INSERT INTO Clientes (rut, nombre, email, telefono, ciudad, fecha_registro)
VALUES ('16.543.210-5', 'Sofía Torres', 'sofia.t@mail.com', '956789012', 'La Serena', '2024-03-05');

-- Consultas Lección 2
--- Consulta 1 Todos los clientes
SELECT * FROM Clientes;

---- Consulta 2 solo nombre y ciudad
SELECT nombre, ciudad FROM Clientes;

--- Consulta 3: Filtrar por ciudad Santiago
SELECT nombre, email, ciudad
FROM Clientes
WHERE ciudad = 'Santiago';


--- Consulta 4 : Filtrar por nombre exacto
SELECT * FROM Clientes
WHERE nombre = 'Ana García';

--- Consulta 5: Nombres que empiezan con M
SELECT nombre, ciudad FROM Clientes
WHERE nombre LIKE 'M%';


-- ================================================================
--  LECCIÓN 3: Tablas Productos y Ventas — JOIN
-- ================================================================

CREATE TABLE Productos (
    id_producto  INTEGER  PRIMARY KEY AUTOINCREMENT,
    nombre       TEXT     NOT NULL,
    categoria    TEXT     NOT NULL,
    precio       REAL     NOT NULL
);

CREATE TABLE Ventas (
    id_venta     INTEGER  PRIMARY KEY AUTOINCREMENT,
    id_cliente   INTEGER  NOT NULL,
    id_producto  INTEGER  NOT NULL,
    cantidad     INTEGER  NOT NULL,
    fecha_venta  TEXT     NOT NULL,
    FOREIGN KEY (id_cliente)  REFERENCES Clientes(id_cliente),
    FOREIGN KEY (id_producto) REFERENCES Productos(id_producto)
);

INSERT INTO Productos (nombre, categoria, precio)
VALUES ('Notebook Lenovo', 'Tecnología', 850000);

INSERT INTO Productos (nombre, categoria, precio)
VALUES ('Mouse Inalámbrico', 'Tecnología', 25000);

INSERT INTO Productos (nombre, categoria, precio)
VALUES ('Teclado Mecánico', 'Tecnología', 75000);

INSERT INTO Productos (nombre, categoria, precio)
VALUES ('Monitor 24"', 'Tecnología', 320000);

INSERT INTO Productos (nombre, categoria, precio)
VALUES ('Silla Ergonómica', 'Mobiliario', 450000);

INSERT INTO Ventas (id_cliente, id_producto, cantidad, fecha_venta)
VALUES (1, 1, 1, '2024-04-01');

INSERT INTO Ventas (id_cliente, id_producto, cantidad, fecha_venta)
VALUES (1, 2, 2, '2024-04-01');

INSERT INTO Ventas (id_cliente, id_producto, cantidad, fecha_venta)
VALUES (2, 3, 1, '2024-04-05');

INSERT INTO Ventas (id_cliente, id_producto, cantidad, fecha_venta)
VALUES (3, 4, 1, '2024-04-10');

INSERT INTO Ventas (id_cliente, id_producto, cantidad, fecha_venta)
VALUES (4, 5, 1, '2024-04-12');

INSERT INTO Ventas (id_cliente, id_producto, cantidad, fecha_venta)
VALUES (5, 2, 3, '2024-04-15');

-- Consultas Lección 3

--- Consulta 1: Qué cliente compró qué producto y cuándo
--- JOIN une las tres tablas usando los id en común
SELECT
    c.nombre      AS cliente,
    p.nombre      AS producto,
    v.cantidad,
    v.fecha_venta
FROM Ventas v
    JOIN Clientes  c ON v.id_cliente  = c.id_cliente
    JOIN Productos p ON v.id_producto = p.id_producto;


--- Consulta 2 : Lo mismo pero ordenado por fecha
SELECT
    c.nombre      AS cliente,
    p.nombre      AS producto,
    v.cantidad,
    v.fecha_venta
FROM Ventas v
    JOIN Clientes  c ON v.id_cliente  = c.id_cliente
    JOIN Productos p ON v.id_producto = p.id_producto
ORDER BY v.fecha_venta;


--- Consulta 3: Ver las compras de un cliente específico
SELECT
    c.nombre      AS cliente,
    p.nombre      AS producto,
    v.cantidad,
    v.fecha_venta
FROM Ventas v
    JOIN Clientes  c ON v.id_cliente  = c.id_cliente
    JOIN Productos p ON v.id_producto = p.id_producto
WHERE c.nombre = 'Ana García';


-- ================================================================
--  LECCIÓN 4: Consultas agrupadas
-- ================================================================

--- COUNT: cuántas ventas hay en total
SELECT COUNT(*) AS total_ventas
FROM Ventas;

-- SUM y AVG: suma y promedio de cantidades vendidas
SELECT SUM(cantidad) AS total_unidades,
       AVG(cantidad) AS promedio_unidades
FROM Ventas;

--- Agrupar ventas por cliente
SELECT c.nombre        AS cliente,
       COUNT(*)        AS cantidad_compras,
       SUM(v.cantidad) AS total_unidades
FROM Ventas v
    JOIN Clientes c ON v.id_cliente = c.id_cliente
GROUP BY c.id_cliente;

--- Agrupar ventas por producto
SELECT p.nombre        AS producto,
       COUNT(*)        AS veces_vendido,
       SUM(v.cantidad) AS total_unidades
FROM Ventas v
    JOIN Productos p ON v.id_producto = p.id_producto
GROUP BY p.id_producto;


--- Calcular el total de ventas por cliente
SELECT c.nombre                        AS cliente,
       SUM(p.precio * v.cantidad)      AS total_gastado
FROM Ventas v
    JOIN Clientes  c ON v.id_cliente  = c.id_cliente
    JOIN Productos p ON v.id_producto = p.id_producto
GROUP BY c.id_cliente
ORDER BY total_gastado DESC;


-- ================================================================
--  LECCIÓN 5: Consultas anidadas
-- ================================================================

---- Listar los clientes que hayan hecho más de una compra.
SELECT nombre
FROM Clientes
WHERE id_cliente IN (
    SELECT id_cliente
    FROM Ventas
    GROUP BY id_cliente
    HAVING COUNT(*) > 1
);


--- Obtener el producto más vendido utilizando una subconsulta.
SELECT p.nombre,
       (SELECT SUM(cantidad) FROM Ventas WHERE id_producto = p.id_producto) AS total_vendido
FROM Productos p
WHERE id_producto = (
    SELECT id_producto
    FROM Ventas
    GROUP BY id_producto
    ORDER BY SUM(cantidad) DESC
    LIMIT 1
);


--- Consultar el cliente que más gastó en total.
SELECT c.nombre, SUM(p.precio * v.cantidad) AS total_gastado
FROM Ventas v
    JOIN Clientes  c ON v.id_cliente  = c.id_cliente
    JOIN Productos p ON v.id_producto = p.id_producto
GROUP BY c.id_cliente
ORDER BY total_gastado DESC
LIMIT 1;


-- ================================================================
--  LECCIÓN 6: Creación y manipulación de tablas
-- ================================================================

ALTER TABLE Productos ADD COLUMN stock INTEGER DEFAULT 0;

UPDATE Productos SET stock = 10 WHERE id_producto = 1;
UPDATE Productos SET stock = 50 WHERE id_producto = 2;
UPDATE Productos SET stock = 30 WHERE id_producto = 3;
UPDATE Productos SET stock = 15 WHERE id_producto = 4;
UPDATE Productos SET stock = 8  WHERE id_producto = 5;

SELECT * FROM Productos;

UPDATE Productos
SET stock = stock - 1
WHERE id_producto = 1;

SELECT nombre, stock FROM Productos WHERE id_producto = 1;

DELETE FROM Ventas   WHERE id_producto = 5;
DELETE FROM Productos WHERE id_producto = 5;

SELECT * FROM Productos;

-- ================================================================
--  FIN DEL SCRIPT
-- ================================================================
