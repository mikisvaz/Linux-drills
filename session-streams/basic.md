Tratamiento basico de streams
=============================

Vamos a aprender a abrir un fichero como un stream y a salvar un stream en un
fichero.

El comando `cat` toma el fichero que se le da como parametro y lo escribe por
STDOUT

* Ejercicio 1: Utiliza `cat` para mostrar por la consola el contenido del
  fichero 'ejemplos/mutations'. SOLUCION: `cat ejemplos/mutations`
  


El comando `zcat` nos permite hacer lo mismo pero con un fichero comprimido,
que sera descromprimido al vuelo

* Ejercicio 2: Utiliza `zcat` para mostrar por la consola el contenido del
  fichero 'ejemplos/mutations.gz'. SOLUCION: `zcat ejemplos/mutations.gz`

Cuando queramos que la salida de un programa se guarde en un fichero en lugar
de mostrarse por la consola utilizamos el simbolo `>`. Por ejemplo `zcat
fichero.gz  > /tmp/fichero_descromprimido`

* Ejercicio 3: Utiliza `zcat` para mostrar por la consola el contenido del
  fichero 'ejemplos/mutations.gz' y guardalo en `tmp/mutations_uncompressed`.
  Tendras que haber creado antes la carpeta `tmp`o el comando no funcionara.
  SOLUCION: `mkdir tmp; zcat ejemplos/mutations.gz > tmp/mutations_uncompressed`


El metodo de descompresion presentado en el ejercicio 3, si bien es tan valido
como cualquier otro, no suele ser el habitual, normalmente se haria `gunzip
ejemplos/mutations.gz` y este directamente lo guardaria como
`ejemplos/mutations`.

El comando `less` (mejora del antiguo `more`) permite ver un stream por la
consola de forma paginada, lo que permite examinar ficheros muy grandes

* Ejercicio 4: Utiliza `cat` para mostrar por la consola el contenido del
  fichero 'ejemplos/mutations' y conectalo con `less` para verlo pagina por
  pagina. SOLUCION: `cat ejemplos/mutations | less`

* Ejercicio 5: Utiliza `cat` para mostrar por la consola el contenido del
  fichero 'ejemplos/mutations' y conectalo con `less` para verlo pagina por
  pagina. Utiliza la funcion de busqueda `/` para encontrar la variante
  '4:144336805:G'.

No hace falta abrir el fichero como stream usando `cat` para pasarselo a
`less`, se puede pasar el nombre del fichero directamente a `less`.

Los comandos `head` y `tail` se pueden usar para extraer las primeras o ultimas
lineas de un fichero. Al igual que `less` se puede hacer sobre la STDIN
(producida al abrir el fichero con `cat` por ejemplo) o dandole el nombre del
fichero directamente.

* Ejercicio 6: Mostrar las 10 primeras, 20 primeras, 10 ultimas y 20 ultimas
  lineas del fichero `ejemplos/mutations`. SOLUCION: `head -n 10 ejemplos/mutations; 
  head -n 20 ejemplos/mutations; tail -n 10 ejemplos/mutations; tail -n 20 ejemplos/mutations`

* Ejercicio 7: Combinar `head` y `tail` para extraer las lineas de la 10 a la
  20 del fichero `ejemplos/mutations`. SOLUCION: `head -n 20 ejemplos/mutations | tail -n 20`

El comando `wc` (word count) sirve para contar lineas, palabras y caracteres. 

* Ejercicio 8: Utilizar `grep` para extraer todas las mutaciones del cromosoma
  "10" y contar cuantas hay utilizando `wc` (numero de lineas). SOLUCION: `grep
  "^10:" ejemplos/mutations | wc -l`
