-- ============================================================
-- SQL E-COMMERCE PRACTICE
-- Ejercicio #14
-- ============================================================
--
-- Pregunta de negocio:
-- ¿Qué clientes gastaron más que el promedio de gasto
-- de todos nuestros clientes?
--
-- Conceptos utilizados:
-- - CTE (Common Table Expression)
-- - SUM()
-- - AVG()
-- - GROUP BY
-- - CROSS JOIN
-- - WHERE
-- - ORDER BY
--
-- ============================================================


-- ============================================================
-- PASO 1: Calcular cuánto gastó cada cliente
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
    GROUP BY
        c.id_cliente,
        c.nombre
)
SELECT
    nombre,
    total_gastado
FROM gasto_clientes
ORDER BY total_gastado DESC;


-- ============================================================
-- PASO 2: Calcular el promedio de gasto de los clientes
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
    GROUP BY
        c.id_cliente,
        c.nombre
)
SELECT
    AVG(total_gastado) AS promedio_gasto
FROM gasto_clientes;


-- ============================================================
-- PASO 3: Mostrar clientes que gastaron más que el promedio
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
    GROUP BY
        c.id_cliente,
        c.nombre
),

promedio_gasto AS (
    SELECT
        AVG(total_gastado) AS promedio
    FROM gasto_clientes
)

SELECT
    gc.nombre,
    gc.total_gastado,
    pg.promedio
FROM gasto_clientes gc
CROSS JOIN promedio_gasto pg
WHERE gc.total_gastado > pg.promedio
ORDER BY gc.total_gastado DESC;


-- ============================================================
-- RESULTADO ESPERADO
-- ============================================================
--
-- Sofia Diaz      | 1410.00 | 764.17
-- Ana Perez       | 1385.00 | 764.17
--
-- ============================================================
