# Proyecto 2: Consultas SQL – Base de Datos Proyecto2

Este proyecto forma parte del módulo de **SQL** del Máster en Data & Analytics.
Las consultas se centran en la exploración, manipulación y extracción de datos de la base de datos **Proyecto2** (una simulación de una empresa de alquiler de películas), con el objetivo de resolver preguntas de negocio complejas mediante el uso de **SQL**.

La información fue extraída mediante **64 consultas** que abarcan desde filtros básicos hasta uniones complejas, subconsultas y ventanas temporales, permitiendo entender el comportamiento de clientes, inventario, facturación, entre otras.

---

## Estructura del Proyecto
El repositorio está organizado para facilitar la comprensión y navegación de los archivos:

proyecto_2_consultas_sql/

├── Enunciado Data Project_SQL.Lógica.pdf # Documento original con todos los ejercicios

├── Esquema Entidad Relación Proyecto 2.png # Diagrama de la base de datos

├── Proyecto2.sql # Archivo principal con las 64 consultas resueltas y comentadas

├── README.md # Descripción general del proyecto y documentación

---

## Herramientas y Tecnologías Utilizadas
- **PostgreSQL / SQL** → Lenguaje principal para la extracción y manipulación de datos.
- **DBeaver / pgAdmin** → Entorno de desarrollo para ejecutar y testear las consultas.
- **Funciones utilizadas:**
    - **Agregación:** COUNT, SUM, AVG, MIN, MAX, STDDEV, VARIANCE.
    - **Manipulación de Texto y Fechas:** CONCAT, EXTRACT, TO_CHAR.
    - **Joins:** `INNER JOIN`, LEFT JOIN, RIGHT JOIN, FULL JOIN, CROSS JOIN.
    - **Lógica Avanzada:** `CASE`, Subconsultas, `HAVING`, Vistas y Tablas Temporales.

---

## Proceso Metodológico de Desarrollo y Apoyo
1. **Análisis del Esquema:** Comprensión de las relaciones entre las 15 tablas (identificación de Primary Keys y Foreign Keys).
2. **Consultas Exploratorias:** Filtrado de datos básicos y ordenamiento para entender la distribución de la información.
3. **Consultas Multitabla:** Uso de 'JOINs' para conectar clientes con alquileres, actores con películas, inventarios con tiendas, etc.
4. **Resolución de Problemas Complejos:** Implementación de lógica de negación ('NOT IN'), filtros de fechas dinámicos, métricas de rendimiento, entre otras.

***

**Nota sobre el proyecto:** Dado que este es un proceso de aprendizaje donde se está adquiriendo la lógica básica, se utilizó apoyo de una IA para clarificar y desarrollar las consultas más complejas. Esto aseguró la comprensión del código y permitió completar el proyecto con el rigor analítico requerido.

***

## Resultados y Conclusiones

- **Total de consultas resueltas:** **64 ejercicios** prácticos de negocio.
- **Análisis de Clientes:** Se identificaron los clientes con mayor valor monetario (Top 5) y aquellos con mayor actividad de alquiler.
- **Gestión de Inventario:** Se detectaron películas no devueltas y se analizó la disponibilidad de títulos por tienda.
- **Rendimiento de Categorías:** Se calculó la duración promedio y la rentabilidad por géneros (ej. 'Sports', 'Sci-Fi').
- **Integridad de Datos:** Se identificaron actores sin películas asignadas y categorías sin alquileres mediante 'LEFT JOIN' y filtros 'IS NULL'.
- **Métricas Financieras:** Cálculo de varianza, desviación estándar y promedios de pago para entender la estabilidad de los ingresos.

---

## Habilidades Demostradas

- **Optimización de Consultas:** Uso eficiente de 'DISTINCT' y filtros previos a la agregación.
- **Manejo de Tiempos:** Cálculo de intervalos (días de alquiler) y extracción de partes de fechas.
- **Creación de Estructuras:** Generación de **Vistas** ('CREATE VIEW') y **Tablas Temporales** ('CREATE TEMPORARY TABLE') para almacenamiento intermedio de datos.
- **Subconsultas Correlacionadas:** Uso de resultados de una consulta (ej. fecha de primer alquiler) como filtro para una consulta principal.

---

## Acceso al Código
**Consulta el archivo SQL completo con las soluciones:**
[Abrir Proyecto2.sql](./Proyecto2.sql)

*(Asegúrate de tener un visualizador de SQL o un editor de texto para ver el código correctamente)*

---

## Próximos Pasos
- Conectar esta base de datos a una herramienta de BI (como Power BI o Tableau) para visualizar los KPIs encontrados.
- Implementar procedimientos almacenados (Stored Procedures) para automatizar reportes recurrentes.

---

## Contribuciones
Las contribuciones y sugerencias son bienvenidas.
Si detectas alguna optimización posible en las consultas, puedes abrir una *issue* o un *pull request*.

---

## Autor
**[Orlan Javier Parra Parra]**
[@orlanjavier6](https://github.com/orlanjavier6)