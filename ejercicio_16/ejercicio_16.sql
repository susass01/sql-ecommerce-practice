-- ============================================================
-- SQL E-COMMERCE PRACTICE
-- Ejercicio #16
-- ============================================================
--
-- Pregunta de negocio:
-- En una tienda online, cuando se vende un producto, es necesario actualizar el stock. 
-- Pero ¿qué pasa si una operación falla y necesitamos deshacer los cambios?
--
--
-- Conceptos utilizados:
-- START TRANSACTION: inicia la transacción.
-- UPDATE: modifica el stock del producto.
-- ROLLBACK: deshace los cambios pendientes.
-- COMMIT: permite confirmar los cambios.
--
-- ============================================================


-- ============================================================
-- PASO 1: Iniciamos una transacción con START TRANSACTION
-- PASO 2: Ejecutar UPDATE para descontar una unidad del stock.
-- ============================================================


START TRANSACTION;

UPDATE productos
SET stock = stock - 1
WHERE id_producto = 1
  AND stock > 0;

-- ============================================================
-- PASO 3: UtilizaR ROLLBACK para deshacer la operación.
-- ============================================================

ROLLBACK;
-- ============================================================
-- PASO 5: Consultamos nuevamente el producto para comprobar que 
-- el stock volvió a su valor original.
-- ============================================================

SELECT id_producto, nombre_producto, stock
FROM productos
WHERE id_producto = 1;
