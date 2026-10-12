-- ============================================================
-- SQL E-COMMERCE PRACTICE
-- Ejercicio #15
-- ============================================================
--
-- Pregunta de negocio:
-- ¿Qué productos generan más facturación y qué porcentaje
-- representan sobre la facturación total?
--
-- Conceptos utilizados:
-- - SUM()
-- - GROUP BY
-- - CTE
-- - SUM() OVER()
-- - ROUND()
-- - ORDER BY
--
-- ============================================================


-- ============================================================
-- PASO 1: Calcular la facturación de cada producto
-- ============================================================

SELECT
    pr.nombre_producto,
    SUM(pr.precio * dp.cantidad) AS facturacion
FROM productos pr
JOIN detalle_pedido dp
    ON pr.id_producto = dp.id_producto
GROUP BY
    pr.id_producto,
    pr.nombre_producto
ORDER BY facturacion DESC;


-- ============================================================
-- PASO 2: Calcular la facturación total
-- ============================================================

SELECT
    SUM(pr.precio * dp.cantidad) AS facturacion_total
FROM productos pr
JOIN detalle_pedido dp
    ON pr.id_producto = dp.id_producto;


-- ============================================================
-- PASO 3: Calcular el porcentaje de participación
-- de cada producto sobre la facturación total
-- ============================================================

WITH facturacion_productos AS (
    SELECT
        pr.id_producto,
        pr.nombre_producto,
        SUM(pr.precio * dp.cantidad) AS facturacion
    FROM productos pr
    JOIN detalle_pedido dp
        ON pr.id_producto = dp.id_producto
    GROUP BY
        pr.id_producto,
        pr.nombre_producto
)
SELECT
    nombre_producto,
    facturacion,
    ROUND(
        facturacion * 100 /
        SUM(facturacion) OVER(),
        2
    ) AS porcentaje_facturacion
FROM facturacion_productos
ORDER BY facturacion DESC;


-- ============================================================
-- RESULTADO DESTACADO
-- ============================================================
--
-- Laptop Dell Inspiron representa aproximadamente
-- el 52% de la facturación total.
--
-- ============================================================
