
-- ============================================================
-- SQL E-COMMERCE PRACTICE
-- Ejercicio #1: Facturación total
-- ============================================================
--
-- Pregunta de negocio:
-- ¿Cuál es la facturación total generada por las ventas?
--
-- Conceptos utilizados:
-- SELECT, SUM(), JOIN
--
-- ============================================================

SELECT
    SUM(pr.precio * dp.cantidad) AS facturacion_total
FROM detalle_pedido dp
JOIN productos pr
    ON dp.id_producto = pr.id_producto;
