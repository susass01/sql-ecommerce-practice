# SQL E-commerce Practice 📊

Proyecto de práctica de SQL desarrollado utilizando una base de datos ficticia de e-commerce.

El objetivo es resolver diferentes preguntas de negocio mediante consultas SQL, avanzando progresivamente desde conceptos básicos hasta consultas de mayor complejidad.

## 🗄️ Base de datos

La base de datos contiene las siguientes tablas:

- `clientes`
- `productos`
- `pedidos`
- `detalle_pedido`

Las tablas están relacionadas mediante claves primarias y foráneas, permitiendo simular operaciones básicas de un e-commerce.

## 💻 Tecnologías utilizadas

- MySQL
- MySQL Workbench
- SQL

## 📚 Conceptos practicados

Durante la serie de ejercicios trabajo con conceptos como:

- SELECT
- WHERE
- SUM()
- COUNT()
- AVG()
- JOIN
- LEFT JOIN
- GROUP BY
- HAVING
- CASE
- Subqueries
- CTE (Common Table Expressions)
- Window Functions
- RANK()
- DENSE_RANK()
- ROW_NUMBER()

## 📝 Ejercicio 13 – Comparación entre registros con LAG() y LEAD()

### 🎯 Objetivo

Analizar el gasto total de cada cliente y compararlo con el gasto del cliente anterior y del siguiente según el orden del total gastado.

### 🔎 Pregunta de negocio

¿Cómo podemos comparar cuánto gastó cada cliente con el cliente que se encuentra inmediatamente antes y después dentro del ranking?

### 💻 Consulta SQL

```sql
WITH gasto_clientes AS (
    SELECT 
        c.id_cliente,
        c.nombre,
        SUM(dp.cantidad * p.precio) AS total_gastado
    FROM clientes c
    JOIN pedidos pe 
        ON c.id_cliente = pe.id_cliente
    JOIN detalle_pedido dp 
        ON pe.id_pedido = dp.id_pedido
    JOIN productos p 
        ON dp.id_producto = p.id_producto
    GROUP BY c.id_cliente, c.nombre
)

SELECT
    nombre,
    total_gastado,
    LAG(total_gastado) OVER (
        ORDER BY total_gastado DESC
    ) AS gasto_cliente_anterior,
    LEAD(total_gastado) OVER (
        ORDER BY total_gastado DESC
    ) AS gasto_cliente_siguiente
FROM gasto_clientes
ORDER BY total_gastado DESC;
```

### 📚 Conceptos utilizados

* `WITH` / CTE
* `SUM()`
* `JOIN`
* `GROUP BY`
* `LAG()`
* `LEAD()`
* Funciones de ventana
* `ORDER BY`

### 💡 ¿Qué hacen LAG() y LEAD()?

`LAG()` permite obtener el valor de una fila anterior dentro del resultado, mientras que `LEAD()` permite obtener el valor de una fila posterior.

En este ejercicio:

* `LAG()` → muestra el gasto del cliente anterior.
* `LEAD()` → muestra el gasto del cliente siguiente.

Esto permite realizar comparaciones entre registros consecutivos sin necesidad de realizar un JOIN de la tabla consigo misma.

### 📊 Ejemplo del resultado

| Cliente     | Total gastado | Cliente anterior | Cliente siguiente |
| ----------- | ------------: | ---------------: | ----------------: |
| Sofia Diaz  |       1410.00 |             NULL |           1385.00 |
| Ana Perez   |       1385.00 |          1410.00 |            360.00 |
| Maria Lopez |        360.00 |          1385.00 |            350.00 |
| Luis Gomez  |        350.00 |           360.00 |              NULL |

### 🚀 Aprendizaje

Con este ejercicio continúo profundizando en el uso de funciones de ventana en SQL y en la comparación de registros dentro de un conjunto de resultados.

Este tipo de funciones puede resultar útil para analizar variaciones, comparar períodos, estudiar ventas consecutivas o detectar cambios entre registros.

## 🚀 Cómo utilizar la base de datos

1. Descargar el archivo `Base_Datos_Ecommerce_Practica_SQL.sql`.
2. Abrir MySQL Workbench.
3. Abrir el script SQL.
4. Ejecutar el script completo.
5. Se creará la base de datos `empresa_demo` con las tablas y datos necesarios para realizar los ejercicios.

## 🎯 Objetivo del proyecto

Este proyecto forma parte de una serie de ejercicios prácticos que realizo para fortalecer mis conocimientos de SQL y aplicar consultas a situaciones similares a las que pueden presentarse en análisis de datos y sistemas.

La base de datos es ficticia y fue creada exclusivamente con fines educativos y de práctica.
