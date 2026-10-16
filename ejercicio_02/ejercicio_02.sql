
-- ============================================================
-- SQL E-COMMERCE PRACTICE
-- Ejercicio #2: Cantidad vendida por producto
-- ============================================================
--
-- Pregunta de negocio:
-- ¿Cuántas unidades se vendieron de cada producto?
--
-- Conceptos utilizados:
-- SELECT, JOIN, SUM(), GROUP BY, ORDER BY
--
-- ============================================================

SELECT
    pr.nombre_producto,
    SUM(dp.cantidad) AS cantidad_vendida
FROM productos pr
JOIN detalle_pedido dp
    ON pr.id_producto = dp.id_producto
GROUP BY pr.nombre_producto
ORDER BY cantidad_vendida DESC;
