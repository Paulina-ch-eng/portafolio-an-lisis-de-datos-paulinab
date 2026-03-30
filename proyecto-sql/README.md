📊 Sistema de Gestión de Ventas — "Comercio Ya"

Proyecto desarrollado en el marco del curso de Análisis de Datos — Módulo 7: SQL


🔹 Descripción
Desarrollo de una base de datos relacional completa para un sistema de gestión de ventas, que permite registrar clientes, productos y transacciones comerciales. El proyecto abarca desde el diseño y creación de tablas hasta la extracción de información estratégica mediante consultas avanzadas.

🔹 Objetivo
Construir una base de datos funcional que permita a un negocio registrar y consultar su actividad comercial: quiénes son sus clientes, qué productos venden, cuánto compra cada cliente y cuáles son los productos más vendidos.

🔹 Desafío
El principal desafío fue diseñar una estructura de datos coherente con relaciones correctas entre tablas (Clientes → Ventas ← Productos), asegurando integridad referencial mediante claves foráneas, y luego extraer información de negocio útil combinando múltiples tablas con distintos niveles de complejidad en las consultas.

🔹 Herramientas utilizadas
HerramientaUsoSQLiteMotor de base de datos relacionalSQL (DDL)CREATE TABLE, ALTER TABLESQL (DML)INSERT, UPDATE, DELETESQL (DQL)SELECT, JOIN, GROUP BY, HAVING, subconsultas

🔹 Modelo Relacional
Clientes (id_cliente, rut, nombre, email, telefono, ciudad, fecha_registro)
    │
    └──► Ventas (id_venta, id_cliente, id_producto, cantidad, fecha_venta)
                                           │
Productos (id_producto, nombre, categoria, precio, stock) ◄──┘

🔹 Actividades realizadas

Diseño del modelo relacional — Creación de tres tablas relacionadas con claves primarias y foráneas
Carga de datos — Inserción de registros: 5 clientes, 5 productos y 6 transacciones de venta
Consultas simples — Filtros por ciudad, nombre y patrones de texto con LIKE
Consultas con JOIN — Cruce de las tres tablas para obtener historial de compras por cliente
Consultas agrupadas — Uso de COUNT, SUM y AVG para analizar comportamiento de compra
Subconsultas anidadas — Identificación del producto más vendido y del cliente con mayor gasto
Modificación de estructura — Agregar columna stock con ALTER TABLE y actualizar con UPDATE
Eliminación de datos — Borrado seguro de registros con DELETE


🔹 Resultados
ConsultaResultadoCliente con mayor gastoAna García — $900.000 CLPProducto más vendido por unidadesMouse Inalámbrico (5 unidades)Clientes con más de una compraAna GarcíaTotal de unidades vendidas10 unidadesPromedio de unidades por venta1,67 unidades

🔹 Habilidades aplicadas

✅ Modelado de bases de datos relacionales
✅ Integridad referencial con claves foráneas
✅ Consultas de análisis con agregaciones y agrupaciones
✅ Subconsultas y filtros avanzados con HAVING
✅ Modificación de esquemas con ALTER TABLE
✅ Manipulación completa de datos (INSERT, UPDATE, DELETE)
Ejecutar el script completo

