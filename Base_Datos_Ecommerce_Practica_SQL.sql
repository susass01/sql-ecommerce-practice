-- ============================================================
-- BASE DE DATOS E-COMMERCE - PRACTICA SQL
-- Serie de ejercicios SQL
-- ============================================================
-- Base ficticia para fines educativos y de práctica.
-- Compatible con MySQL / MySQL Workbench.
-- ============================================================

DROP DATABASE IF EXISTS empresa_demo;
CREATE DATABASE empresa_demo;
USE empresa_demo;

-- ============================================================
-- 1. TABLA CLIENTES
-- ============================================================

CREATE TABLE clientes (
    id_cliente INT PRIMARY KEY,
    nombre VARCHAR(50),
    email VARCHAR(100),
    ciudad VARCHAR(50),
    fecha_registro DATE
);

-- ============================================================
-- 2. TABLA PRODUCTOS
-- ============================================================

CREATE TABLE productos (
    id_producto INT PRIMARY KEY,
    nombre_producto VARCHAR(100),
    categoria VARCHAR(50),
    precio DECIMAL(10,2),
    stock INT
);

-- ============================================================
-- 3. TABLA PEDIDOS
-- ============================================================

CREATE TABLE pedidos (
    id_pedido INT PRIMARY KEY,
    id_cliente INT,
    fecha_pedido DATE,
    estado VARCHAR(30),
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

-- ============================================================
-- 4. TABLA DETALLE_PEDIDO
-- ============================================================

CREATE TABLE detalle_pedido (
    id_detalle INT PRIMARY KEY,
    id_pedido INT,
    id_producto INT,
    cantidad INT,
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido),
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);

-- ============================================================
-- DATOS DE PRUEBA
-- ============================================================

INSERT INTO clientes
    (id_cliente, nombre, email, ciudad, fecha_registro)
VALUES
    (1, 'Ana Perez', 'ana@gmail.com', 'Buenos Aires', '2025-01-10'),
    (2, 'Luis Gomez', 'luis@gmail.com', 'Cordoba', '2025-02-11'),
    (3, 'Maria Lopez', 'maria@gmail.com', 'Rosario', '2025-03-20'),
    (4, 'Carlos Ruiz', 'carlos@gmail.com', 'Mendoza', '2025-04-01'),
    (5, 'Sofia Diaz', 'sofia@gmail.com', 'Buenos Aires', '2025-04-18'),
    (6, 'Pedro Alvarez', 'pedro@gmail.com', 'La Plata', '2025-05-10'),
    (7, 'Laura Martinez', 'laura@gmail.com', 'Buenos Aires', '2025-06-15'),
    (8, 'Diego Fernandez', 'diego@gmail.com', 'Cordoba', '2025-06-16');

INSERT INTO productos
    (id_producto, nombre_producto, categoria, precio, stock)
VALUES
    (1, 'Laptop Dell Inspiron', 'Tecnologia', 1200.00, 15),
    (2, 'Mouse Logitech', 'Accesorios', 45.00, 100),
    (3, 'Teclado Mecanico', 'Accesorios', 95.00, 70),
    (4, 'Monitor Samsung 24', 'Tecnologia', 350.00, 30),
    (5, 'Auriculares Sony', 'Audio', 180.00, 40),
    (6, 'Webcam HD', 'Accesorios', 75.00, 50);

INSERT INTO pedidos
    (id_pedido, id_cliente, fecha_pedido, estado)
VALUES
    (1, 1, '2025-06-01', 'Entregado'),
    (2, 2, '2025-06-03', 'Entregado'),
    (3, 1, '2025-06-05', 'Pendiente'),
    (4, 3, '2025-06-08', 'Entregado'),
    (5, 5, '2025-06-10', 'Entregado'),
    (6, 7, '2025-06-15', 'Entregado'),
    (7, 8, '2025-06-16', 'Entregado');

INSERT INTO detalle_pedido
    (id_detalle, id_pedido, id_producto, cantidad)
VALUES
    (1, 1, 1, 1),
    (2, 1, 2, 2),
    (3, 2, 4, 1),
    (4, 3, 3, 1),
    (5, 4, 5, 2),
    (6, 5, 1, 1),
    (7, 5, 6, 1),
    (8, 5, 2, 3),
    -- Estos dos registros generan un empate de $540
    -- para practicar RANK(), DENSE_RANK() y ROW_NUMBER().
    (9, 6, 5, 3),
    (10, 7, 5, 3);

-- ============================================================
-- CONSULTAS DE VERIFICACION
-- ============================================================

SELECT * FROM clientes ORDER BY id_cliente;
SELECT * FROM productos ORDER BY id_producto;
SELECT * FROM pedidos ORDER BY id_pedido;
SELECT * FROM detalle_pedido ORDER BY id_detalle;

-- Total gastado por cliente
SELECT
    c.id_cliente,
    c.nombre,
    SUM(pr.precio * dp.cantidad) AS total_gastado
FROM clientes c
JOIN pedidos p
    ON c.id_cliente = p.id_cliente
JOIN detalle_pedido dp
    ON p.id_pedido = dp.id_pedido
JOIN productos pr
    ON dp.id_producto = pr.id_producto
GROUP BY c.id_cliente, c.nombre
ORDER BY total_gastado DESC;

-- ============================================================
-- EJEMPLO: RANK(), DENSE_RANK() Y ROW_NUMBER()
-- ============================================================

WITH gasto_clientes AS (
    SELECT
        c.id_cliente,
        c.nombre,
        SUM(pr.precio * dp.cantidad) AS total_gastado
    FROM clientes c
    JOIN pedidos p
        ON c.id_cliente = p.id_cliente
    JOIN detalle_pedido dp
        ON p.id_pedido = dp.id_pedido
    JOIN productos pr
        ON dp.id_producto = pr.id_producto
    GROUP BY c.id_cliente, c.nombre
)
SELECT
    nombre,
    total_gastado,
    RANK() OVER (
        ORDER BY total_gastado DESC
    ) AS ranking_rank,
    DENSE_RANK() OVER (
        ORDER BY total_gastado DESC
    ) AS ranking_dense,
    ROW_NUMBER() OVER (
        ORDER BY total_gastado DESC
    ) AS numero_fila
FROM gasto_clientes;

-- ============================================================
-- FIN DEL SCRIPT
-- ============================================================
