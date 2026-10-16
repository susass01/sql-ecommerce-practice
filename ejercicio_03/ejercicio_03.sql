
-- ============================================================
-- SQL E-COMMERCE PRACTICE
-- Ejercicio #3: Producto más vendido
-- ============================================================
--
-- Pregunta de negocio:
-- ¿Cuál es el producto con mayor cantidad de unidades vendidas?
--
-- Conceptos utilizados:
-- SELECT, JOIN, SUM(), GROUP BY, ORDER BY, LIMIT
--
-- ============================================================

SELECT
    pr.nombre_producto,
    SUM(dp.cantidad) AS cantidad_vendida
FROM productos pr
JOIN detalle_pedido dp
    ON pr.id_producto = dp.id_producto
GROUP BY
    pr.id_producto,
    pr.nombre_producto
ORDER BY cantidad_vendida DESC
LIMIT 1;
