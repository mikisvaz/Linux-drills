Guion de Proyecto
==================

Para realizar un proyecto que desempeñe una funcionalidad concreta la
aproximacion es en general es:

* Determinar que recursos vamos a necesitar
* Obtener estos recursos y ponerlos en algun directorio concreto, como `data`
* Examinarlos con `less`, `head`, `tail` o el comando `numera_tabs` para
  entender como esta almacenada la informacion
* En caso de que sea necesario, transformamos los ficheros de entrada a un
  formato mas conveniente o filtramos la informacion que queremos. Esto puede
  suponer utilizar `sed` para reformatear la informacion, `grep` para
  filtrarla, o `cut` para extraer los campos relevantes
* Definimos como va ser el proceso de lo que queremos hacer
* Escribimos el script

Segun vamos escribiendo el script hay algunas pautas que podemos seguir:

* Tratad de dividir el proceso en pasos e id complentandolos uno a uno. El
  hacer pequeños pasos y comprobar que van bie es importante por dos motivos:
  (1) te das cuanta pronto de errores o problemas y (2) obtienes una pequeña
  satisfaccion cada vez que haces un paso. Parece una tonteria pero el segundo
  punto es muy importante para disfrutar de la programacion.
* Aunque veais en mis ejemplos que hago unas cosas despues de otras, en
  realidad no es ese el orden en que se escriben. Segun vamos avanzando en el
  script tendremos que volver atras para añadir nuevos paths a ficheros,
  preparar nuevos recursos, etc.
* No trateis de hacer la solucion perfecta a la primera. Es mejor llegar a
  tener todo el proceso de cabo a rabo implementado, aunque no este del todo
  correcto, y luego proceder a corregirlo. Es mas facil hacer una mejora a un
  programa completo que a uno a medias por que asi se pueden comprobar
  inmediatamente como afectan los cambios a todo el proceso. En nuestro
  ejemplo la parte de filtrar los genes 'malos' se programa una vez tenemos
  todo lo demas terminado.
* En algunos casos los ficheros de entrada los prepararemos antes del programar
  el script, en otros casos los programaremos dentro del script. Depende un
  poco de cada uno. En mi caso, problemas con el formato los arreglo antes del
  script, mientras que preparar datos para obtener informacion concreta lo hago
  dentro del script. El tema de los genes 'malos' se podria haber hecho de
  cualquier de las dos formas.
* Cuando tengamos que hacer algun procesamiento que requiera usar `sed`,
  `grep`, etc. de manera no obvia, es util probar un ejemplito en la terminal
  hasta ver que realmente tenemos la solucion correcta antes de escribirlo en
  el script. Esto es cierto tambien cuando concatenamos varios comandos en una
  sola linea
* Si la funcionalidad que hemos desarrollado queremos que se pueda usar y
  mejorar en el tiempo, es util crear algunos ejemplos y tests sencillos que
  nos permitan comprobar su correcto funcionamiento. En programacion hay mucha
  gente que escribe los tests incluso antes de escribir el codigo, lo que se
  denomina 'test driven development'

He añadido una serie de comentarios al script de 'enrichment.sh' explicando que
se hace en cada paso. Recordad que este proceso es muy iterativo. Por ejemplo
yo implemente la funcionalidad de traducir genes antes de caer en la cuenta de
que habia estos genes 'malos' (lo sabia de antes, pero no habia caido en la
cuenta), para lo que me plantee de nuevo que recursos necesitaba para
arreglarlo, donde ponerlos, etc.