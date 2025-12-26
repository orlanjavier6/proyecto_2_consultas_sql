--DataProject: LógicaConsultasSQL

--1. Crea el esquema de la BBDD: se llama: Esquema Entidad Relación Proyecto 2.

--2. Muestra los nombres de todas las películas con una clasificación por
edades de ‘R’.
select title as nombre_película, rating as clasificación
from film
where rating = 'R';

--3. Encuentra los nombres de los actores que tengan un “actor_id” entre 30 y 40.
select "first_name" , "last_name" , "actor_id"
from "actor"
where actor_id between 30 and 40;

--4. Obtén las películas cuyo idioma coincide con el idioma original.
select "title" as "nombre_película"
from "film"
where "language_id" = original_language_id;

--5. Ordena las películas por duración de forma ascendente.
select "title" as "nombre_película" , "length" as "duración_película"
from "film"
order by "length" asc;

--6. Encuentra el nombre y apellido de los actores que tengan ‘Allen’ en su apellido.
select "first_name" as "nombre" , "last_name" as "apellido"
from "actor"
where "last_name" like '%Allen%';

--7. Encuentra la cantidad total de películas en cada clasificación de la tabla
--“film” y muestra la clasificación junto con el recuento
select "rating" as "clasificación" ,
count (*) as "total_películas"
from "film"
group by "rating";

--8. Encuentra el título de todas las películas que son ‘PG-13’ o tienen una
--duración mayor a 3 horas en la tabla film.
select "title" as "título_película" , "rating" as "clasificación" , "length" as "duración_película"
from "film"
where "rating" = 'PG-13' or "length" > 180 ;

--9. Encuentra la variabilidad de lo que costaría reemplazar las películas.
select round(variance("replacement_cost"),2) as "varianza"
from "film";

--10. Encuentra la mayor y menor duración de una película de nuestra BBDD.
select Min("length") as "Total_mínimo", max ("length") as "Total_máximo"
from "film" f;

--11. Encuentra lo que costó el antepenúltimo alquiler ordenado por día.
select p.amount as costo_alquiler
from payment p
inner join
    (
        select rental_id
        from rental
        order by rental_date desc
        limit 1 offset 2
    ) as antepenultimo_alquiler
    on p.rental_id = antepenultimo_alquiler.rental_id;

--12. Encuentra el título de las películas en la tabla “film” que no sean ni ‘NC17’ ni ‘G’ en cuanto a su clasificación.
select "title" as "nombre_película" , "rating" as "clasificación"
from "film"
where "rating" not in ('NC-17' , 'G');

--13. Encuentra el promedio de duración de las películas para cada
--clasificación de la tabla film y muestra la clasificación junto con el
--promedio de duración.
select "rating" as "clasificación" , round(avg ("length"),2) as "promedio_duración"
from "film"
group by "rating";

--14. Encuentra el título de todas las películas que tengan una duración mayor a 180 minutos.
select "title" as "título_película", "length" as "duración_película"
from "film"
where "length" > 180;

--15. ¿Cuánto dinero ha generado en total la empresa?
select sum("amount") as "total_empresa"
from "payment";

--16. Muestra los 10 clientes con mayor valor de id.
select "customer_id" as "valor_id" , concat(first_name, ' ', last_name ) as nombre_completo
from "customer"
order by "customer_id" desc limit 10 ;

--17. Encuentra el nombre y apellido de los actores que aparecen en la película con título ‘Egg Igby’.
select
    a.first_name as nombre_actor,
    a.last_name as apellido_actor
from
    actor a
inner join
    film_actor fa on a.actor_id = fa.actor_id
inner join
    film f on fa.film_id = f.film_id
where
    f.title = 'Egg Igby';

--18. Selecciona todos los nombres de las películas únicos.
select distinct "title" as "nombre_películas_únicos"
from "film";

--19. Encuentra el título de las películas que son comedias y tienen una
--duración mayor a 180 minutos en la tabla “film”.
select
    f.title as título_película,
    f.length as duración_minutos,
    c.name as categoría
from
    film f
inner join
    film_category fc on f.film_id = fc.film_id
inner join
    category c on fc.category_id = c.category_id
where
    c.name = 'Comedy'
    and f.length > 180;

--20. Encuentra las categorías de películas que tienen un promedio de
--duración superior a 110 minutos y muestra el nombre de la categoría
--junto con el promedio de duración
select
    c.name as categoría,
    round(avg(f.length),2) as promedio_duración_minutos
from
    film f
inner join
    film_category fc on f.film_id = fc.film_id
inner join
    category c on fc.category_id = c.category_id
group by
    c.name
having
    avg(f.length) > 110;

--21. ¿Cuál es la media de duración del alquiler de las películas?
select round(avg("rental_duration"),2) as "media_duración_alquiler"
from "film";

--22. Crea una columna con el nombre y apellidos de todos los actores y actrices
select concat(first_name, ' ', last_name ) as nombre_completo
from actor a;

--23. Números de alquiler por día, ordenados por cantidad de alquiler de forma descendente.
select cast (rental_date as date) as "alquiler_día" ,
count (*) as "cantidad_alquiler"
from rental
group by "alquiler_día"
order by "cantidad_alquiler" desc;

--24. Encuentra las películas con una duración superior al promedio.
select				
	title as nombre_película,
    length as duración_minutos
from film
where
    length > (
        select
            avg(length)
        from
            film
    );

--25. Averigua el número de alquileres registrados por mes.
select to_char(rental_date, 'YYYY-month') as "alquiler_mes",
count (*) as "cantidad_alquiler"
from rental
group by "alquiler_mes"
order by
    alquiler_mes;

--26. Encuentra el promedio, la desviación estándar y varianza del total pagado.
select
	round(avg("amount"),2) as promedio_total_pagado,
	round(stddev("amount"),2) as desviación_total_pagado,
	round(variance("amount"),2) as varianza_total_pagado
from "payment";

--27. ¿Qué películas se alquilan por encima del precio medio?
select				
	title as nombre_película,
    rental_rate as precio_alquiler_película
from film
where
    rental_rate > (
        select
            avg(rental_rate)
        from
            film
    );

--28. Muestra el id de los actores que hayan participado en más de 40 películas
select
    fa.actor_id as id_actor,
    count(fa.film_id) as total_películas
from film_actor fa
group by fa.actor_id
having count(fa.film_id) > 40;

--29. Obtener todas las películas y, si están disponibles en el inventario, mostrar la cantidad disponible.
select
    f.title as título_película,
    count(i.inventory_id) as cantidad_disponible
from 
    film f
left join
    inventory i on f.film_id = i.film_id
group by
    f.film_id, f.title
order by
    cantidad_disponible desc;

--30. Obtener los actores y el número de películas en las que ha actuado.
select
    concat(first_name, ' ', last_name ) as nombre_completo,
    count(fa.film_id) as total_películas
from actor a
inner join
	film_actor fa on a.actor_id = fa.actor_id
group by a.actor_id, nombre_completo
order by total_películas;

--31. Obtener todas las películas y mostrar los actores que han actuado en
--ellas, incluso si algunas películas no tienen actores asociados.
select
    title as título_película,
	concat(first_name, ' ', last_name ) as nombre_completo
from film f
left join
	film_actor fa on f.film_id = fa.film_id
left join
	actor a on fa.actor_id = a.actor_id
order by title, nombre_completo;

--32. Obtener todos los actores y mostrar las películas en las que han
--actuado, incluso si algunos actores no han actuado en ninguna película.
select
    concat(first_name, ' ', last_name ) as nombre_completo,
    title as título_película
from film f
right join
	film_actor fa on f.film_id = fa.film_id
right join
	actor a on fa.actor_id = a.actor_id
order by nombre_completo, title;

--33. Obtener todas las películas que tenemos y todos los registros de alquiler.
select
    title as título_película,
    r.rental_date as fecha_alquiler,
    r.return_date as fecha_devolución
from film f
full join
	inventory i on f.film_id = i.film_id
full join
	rental r on i.inventory_id = r.inventory_id
order by título_película, r.rental_date, r.return_date ;

--34. Encuentra los 5 clientes que más dinero se hayan gastado con nosotros.
select
    concat(first_name, ' ', last_name ) as nombre_completo,
    sum(p.amount) as cantidad_dinero
from customer c
inner join
	payment p on c.customer_id = p.customer_id
group by c.customer_id, nombre_completo
order by cantidad_dinero desc
limit 5;

--35. Selecciona todos los actores cuyo primer nombre es 'Johnny'.
select "first_name" as "nombre"
from actor
where UPPER(first_name) = 'JOHNNY';

--36. Renombra la columna “first_name” como Nombre y “last_name” como Apellido.
select 
	"first_name" as "Nombre",
	"last_name"	as "Apellido"
from actor a
order by first_name, last_name;

--37. Encuentra el ID del actor más bajo y más alto en la tabla actor.
select min("actor_id") as "Total_mínimo", max ("actor_id") as "Total_máximo"
from "actor" a;

--38. Cuenta cuántos actores hay en la tabla “actor”.
select count("actor_id") as "total_actores"
from "actor" a;

--39. Selecciona todos los actores y ordénalos por apellido en orden ascendente.
select "first_name" as "Nombre_actor", "last_name" as "Apellido_actor"
from actor
order by last_name;

--40. Selecciona las primeras 5 películas de la tabla “film”
select "title" as "Película"
from film
limit 5;

--41. Agrupa los actores por su nombre y cuenta cuántos actores tienen el
--mismo nombre. ¿Cuál es el nombre más repetido?
select "first_name" as "Nombre_actor" ,
count (*) as "Mismo_nombre"
from "actor"
group by "first_name"
order by "Mismo_nombre" desc;
--Los nombres más repetidos son: Kenneth, Penelope y Julia. 

--42. Encuentra todos los alquileres y los nombres de los clientes que los realizaron.
select
    concat(first_name, ' ', last_name ) as nombre_completo,
    r.rental_date as fecha_alquiler
from customer c
inner join
	rental r on c.customer_id = r.customer_id;

--43. Muestra todos los clientes y sus alquileres si existen, incluyendo aquellos que no tienen alquileres.
select
    concat(first_name, ' ', last_name ) as nombre_completo,
    r.rental_date as fecha_alquiler
from customer c
left join
	rental r on c.customer_id = r.customer_id;

--44. Realiza un CROSS JOIN entre las tablas film y category. ¿Aporta valor
--esta consulta? ¿Por qué? Deja después de la consulta la contestación.
select *
from "film" f
cross join "category" c;
--No aporta valor para nada, ya que hace muchas combinaciones con todas las filas de ambas tablas, y al final no ofrece un resultado para el análisis.

--45. Encuentra los actores que han participado en películas de la categoría 'Action'.
select
    concat(a.first_name,' ',a.last_name ) as nombre_completo,
    name as categoría_película
from category c 
inner join
	film_category fc on c.category_id = fc.category_id
inner join
	film f on fc.film_id = f.film_id 
inner join
	film_actor fa on f.film_id = fa.film_id
inner join
	actor a on fa.actor_id = a.actor_id
where
    c.name = 'Action'
order by nombre_completo, name;

--46. Encuentra todos los actores que no han participado en películas.
select
    concat(first_name, ' ', last_name ) as nombre_completo,
    a.actor_id
from actor a
left join
	film_actor fa on a.actor_id = fa.actor_id
where fa.film_id is NULL;

--47. Selecciona el nombre de los actores y la cantidad de películas en las que han participado.
select
    concat(a.first_name, ' ',a.last_name ) as nombre_completo,
	count(fa.film_id) as cantidad_películas
from actor a
inner join
	film_actor fa on a.actor_id = fa.actor_id
group by
	a.actor_id, nombre_completo
order by cantidad_películas desc;

--48. Crea una vista llamada “actor_num_peliculas” que muestre los nombres
--de los actores y el número de películas en las que han participado.
create view actor_num_peliculas as
select
	concat(a.first_name, ' ',a.last_name ) as nombre_completo,
	count(fa.film_id) as cantidad_películas
from actor a
	inner join
	film_actor fa on a.actor_id = fa.actor_id
group by
	a.actor_id, nombre_completo
order by cantidad_películas desc;

select*from actor_num_peliculas tca;

--49. Calcula el número total de alquileres realizados por cada cliente.
select
    concat(c.first_name, ' ', c.last_name ) as nombre_completo,
    count(r.rental_id) as total_alquileres
from customer c
left join
	rental r on c.customer_id = r.customer_id
group by
	c.customer_id, "nombre_completo"
order by total_alquileres desc;

--50. Calcula la duración total de las películas en la categoría 'Action'.
select
    c.name as categoría_película,
    sum(f.length) as duración_total
from category c 
inner join
	film_category fc on c.category_id = fc.category_id
inner join
	film f on fc.film_id = f.film_id 
where
    c.name = 'Action'
group by
    c.name;

--51. Crea una tabla temporal llamada “cliente_rentas_temporal” para
--almacenar el total de alquileres por cliente.
CREATE TEMPORARY TABLE "Cliente_rentas_temporal" AS 
select
    concat(c.first_name, ' ', c.last_name ) as nombre_completo,
    count(r.rental_id) as total_alquileres
from customer c
left join
	rental r on c.customer_id = r.customer_id
group by
	c.customer_id, "nombre_completo"
order by total_alquileres desc;

select *
from "Cliente_rentas_temporal";

--52. Crea una tabla temporal llamada “peliculas_alquiladas” que almacene las
--películas que han sido alquiladas al menos 10 veces.
create temporary table "películas_alquiladas" as
select
    f.title as titulo_pelicula,
    count(r.rental_id) as total_alquileres
from
    film f
inner join
    inventory i on f.film_id = i.film_id
inner join
    rental r on i.inventory_id = r.inventory_id
group by
	f.film_id, f.title
having
    count(r.rental_id) >= 10
order by
    total_alquileres desc;

select *
from "películas_alquiladas";

--53. Encuentra el título de las películas que han sido alquiladas por el cliente
--con el nombre ‘Tammy Sanders’ y que aún no se han devuelto. Ordena
--los resultados alfabéticamente por título de película.
select
    f.title as titulo_pelicula
from
    customer c
inner join
    rental r on c.customer_id = r.customer_id
inner join
    inventory i on r.inventory_id = i.inventory_id
inner join
    film f on i.film_id = f.film_id
where
    c.first_name = 'TAMMY' and c.last_name = 'SANDERS'
    and r.return_date is null
order by
    titulo_pelicula asc;
--Aquí y en otras pude entender un poco y hacerlo por mi propia cuenta, por lo que utilicé un poco una IA para que me explicara un poco más y poder hacer lo que más pude.

--54. Encuentra los nombres de los actores que han actuado en al menos una
--película que pertenece a la categoría ‘Sci-Fi’. Ordena los resultados alfabéticamente por apellido.
select distinct
    a.first_name as nombre_actor,
    a.last_name as apellido_actor,
    c.name as categoría_película
from
    actor a
inner join
    film_actor fa on a.actor_id = fa.actor_id
inner join
    film_category fc on fa.film_id = fc.film_id
inner join
    category c on fc.category_id = c.category_id
where
    c.name = 'Sci-Fi'
order by
    a.last_name;

--55. Encuentra el nombre y apellido de los actores que han actuado en
--películas que se alquilaron después de que la película ‘Spartacus
--Cheaper’ se alquilara por primera vez. Ordena los resultados
--alfabéticamente por apellido.
select distinct
    a.first_name as nombre_actor,
    a.last_name as apellido_actor
from
    actor a
inner join
    film_actor fa on a.actor_id = fa.actor_id
inner join
    film f on fa.film_id = f.film_id
inner join
    inventory i on f.film_id = i.film_id
inner join
    rental r on i.inventory_id = r.inventory_id
where
    r.rental_date > (
        select
            min(r1.rental_date)
        from
            rental r1
        inner join
            inventory i1 on r1.inventory_id = i1.inventory_id
        inner join
            film f1 on i1.film_id = f1.film_id
        where
            f1.title = 'SPARTACUS CHEAPER'
    )
order by
    a.last_name asc;

--56. Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría ‘Music’.
--Encuentra todos los actores que no han participado en películas.
select
    concat(a.first_name, ' ', a.last_name) as nombre_completo,
    c.name as categoría_película
from actor a
inner join film_actor fa on a.actor_id = fa.actor_id
inner join film_category fc on fa.film_id = fc.film_id
inner join category c on fc.category_id = c.category_id
where a.actor_id not in (
    -- Esta subconsulta identifica a los actores que si han actuado en 'Music'
    select fa2.actor_id
    from film_actor fa2
    inner join film_category fc2 on fa2.film_id = fc2.film_id
    inner join category c2 on fc2.category_id = c2.category_id
    where c2.name = 'Music'
)
order by nombre_completo, categoría_película;


--57. Encuentra el título de todas las películas que fueron alquiladas por más de 8 días.
select distinct
    f.title as título_película
from
    film f
inner join
    inventory i on f.film_id = i.film_id
inner join
    rental r on i.inventory_id = r.inventory_id
where
    extract(day from (r.return_date - r.rental_date)) > 8
order by
    f.title;

--58. Encuentra el título de todas las películas que son de la misma categoría que ‘Animation’.
select
    f.title as nombre_película,
    c.name as categoría_película
from category c 
inner join
	film_category fc on c.category_id = fc.category_id
inner join
	film f on fc.film_id = f.film_id 
where
    c.name = 'Animation'
order by f.title, c.name;

--59. Encuentra los nombres de las películas que tienen la misma duración
--que la película con el título ‘Dancing Fever’. Ordena los resultados
--alfabéticamente por título de película.
select
    f.title as título_película,
    f.length as duración_minutos
from
    film f
where
    f.length = (
        select
            f1.length
        from
            film f1
        where
            f1.title = 'Dancing Fever'
    )
    and f.title <> 'Dancing Fever'
order by
    f.title asc;

--60. Encuentra los nombres de los clientes que han alquilado al menos 7
--películas distintas. Ordena los resultados alfabéticamente por apellido.
select
    c.first_name as nombre_cliente,
    c.last_name as apellido_cliente,
    count(distinct i.film_id) as peliculas_distintas_alquiladas
from
    customer c
inner join 
    rental r on c.customer_id = r.customer_id
inner join
    inventory i on r.inventory_id = i.inventory_id
group by
    c.customer_id, nombre_cliente, c.last_name
having
    count(distinct i.film_id) >= 7
order by
    c.last_name asc;

--61. Encuentra la cantidad total de películas alquiladas por categoría y
--muestra el nombre de la categoría junto con el recuento de alquileres.
select
    c.name as nombre_categoria,
    count(r.rental_id) as total_alquileres
from
    category c
inner join
    film_category fc on c.category_id = fc.category_id
inner join
    inventory i on fc.film_id = i.film_id
inner join
    rental r on i.inventory_id = r.inventory_id
group by
    c.name
order by
    total_alquileres desc;

--62. Encuentra el número de películas por categoría estrenadas en 2006.
select
    c.name as categoría,
    count(f.film_id) as películas_2006
from
    category c
inner join
    film_category fc on c.category_id = fc.category_id
inner join
    film f on fc.film_id = f.film_id
where
    f.release_year = 2006
group by
    c.name
order by
    películas_2006 desc;

--63. Obtén todas las combinaciones posibles de trabajadores con las tiendas que tenemos.
select
    concat(s.first_name, ' ', s.last_name) as nombre_empleado,
    st.store_id as tienda
from
    staff s
cross join
    store st;

--64. Encuentra la cantidad total de películas alquiladas por cada cliente y
--muestra el ID del cliente, su nombre y apellido junto con la cantidad de películas alquiladas.
select
    c.customer_id as id_cliente,
    concat(c.first_name, ' ', c.last_name) as nombre_completo,
    count(r.rental_id) as películas_alquiladas
from
    customer c
left join
    rental r on c.customer_id = r.customer_id
group by
    c.customer_id, nombre_completo
order by
    películas_alquiladas desc;