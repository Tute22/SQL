--año de nacimineto
SELECT name, year 
FROM movies 
WHERE year=2001;


--1982
SELECT COUNT (*) year 
FROM movies 
WHERE year=1982;


--stacktors
SELECT * 
FROM actors 
WHERE first_name 
LIKE '%stack%' OR last_name LIKE '%stack%';


--nombre de la fama
SELECT first_name, COUNT(*) occurrences
FROM actors 
GROUP BY first_name 
ORDER BY COUNT(first_name) DESC 
LIMIT 10;

SELECT last_name, COUNT(*) occurrences
FROM actors 
GROUP BY last_name 
ORDER BY COUNT(last_name) DESC 
LIMIT 10;

SELECT first_name || ' ' || last_name as full_name, COUNT(*) as occurrences
FROM actors 
GROUP BY full_name
ORDER BY COUNT(*) DESC 
LIMIT 10;


--prolífico
SELECT first_name, last_name, COUNT(role)
FROM actors 
LEFT JOIN roles ON actors.id=roles.actor_id
GROUP BY first_name, last_name
ORDER BY COUNT (role) DESC
LIMIT 100;


--fondo del barril
SELECT genre, COUNT(*) as num_movies_by_genres
FROM movies_genres
LEFT JOIN movies ON movies.id=movies_genres.movie_id
GROUP BY genre
ORDER BY COUNT(*);


--braveheart
SELECT first_name, last_name
FROM actors 
JOIN roles ON actors.id=roles.actor_id
LEFT JOIN movies ON movies.id=roles.movie_id
WHERE movies.name = 'Braveheart' AND movies.year = 1995
ORDER BY last_name ASC;


--noir bisiesto
SELECT directors.first_name, directors.last_name, name, year
FROM movies 
INNER JOIN movies_genres ON movies.id = movies_genres.movie_id
INNER JOIN movies_directors ON movies_genres.movie_id = movies_directors.movie_id
INNER JOIN directors ON movies_directors.director_id = directors.id
WHERE  year % 4 = 0 AND movies_genres.genre = 'Film-Noir';


--kevin bacon 
SELECT pelicula, actors.first_name, actors.last_name
FROM (SELECT movies.name AS 'pelicula', actors.first_name, actors.last_name, movies.id AS 'id_pelicula'
FROM roles
INNER JOIN actors ON roles.actor_id = actors.id
INNER JOIN movies ON roles.movie_id = movies.id
INNER JOIN movies_genres ON movies.id = movies_genres.movie_id
WHERE actors.first_name = 'Kevin' AND actors.last_name = 'Bacon' AND movies_genres.genre = 'Drama') AS 'tabla_kevin'
INNER JOIN roles ON tabla_kevin.id_pelicula = roles.movie_id 
INNER JOIN actors ON roles.actor_id = actors.id
WHERE NOT actors.first_name = 'Kevin' AND NOT actors.last_name = 'Bacon'
LIMIT 100;


--actores inmortales
SELECT first_name, last_name, id
FROM actors
WHERE id IN(
  SELECT actor_id
  FROM roles 
  WHERE movie_id IN(
  SELECT id
  FROM movies
  WHERE year < 1900
)
)
INTERSECT
SELECT first_name, last_name, id
FROM actors
WHERE id IN(
  SELECT actor_id
  FROM roles 
  WHERE movie_id IN(
  SELECT id
  FROM movies
  WHERE year > 2000
)
)
ORDER BY id;


--ocupados en filmación 
