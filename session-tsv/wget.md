Wget
====

El comando `wget` permite descargarse un contenido de internet sin necesidad de
utilizar un navegador. Alternativamente puede usarse tambien el comando `curl`,
que tiene alguna funcionalidad mas avanzada. 

El uso que vamos a dar a `wget` es sencillo. Vamos a buscar el contenido que
queramos con el navegador, copiaremos la URL y luego utilizaremos `wget` para
descargarla. La ventaja es que podemos poner esta URL en nuestro script para
asi descargarla cuando queramos sin necesidad de abrir de nuevo nuestro
navegador. 

`wget "<URL>" -O <fichero_destino>`

Aunque el uso que vamos a dar a `wget` es el de simplemente bajar un fichero,
este comando es capaz tambien de procesar recursivamente paginas HTML,
siguiendo los links de la pagina, para descargarse todas los recursos de cierto
tipo, como imagenes. 

* Ejercicio 1: Descargarse las interaciones entre proteinas para _Rattus
  norvegicus_ de la base de datos PINA2 en formato MITAB (TSV). Guardadlas en 
  la subcarpeta `results`.
  SOLUCION: `wget "http://cbg.garvan.unsw.edu.au/pina/download/Rattus%20norvegicus-20140521.tsv" -O tmp/rat.mitab`

* Ejercicio 2: utilizad `sed` para realizar las siguientes modificaciones al
  archivo: (1) Eliminad de la cabecera las comillas, (2) añadir el caracter "#"
  al principio de dicha cabecera, y (3) eliminar el prefijo 'uniprotkb:' que
  precede a los codigos de UniProt de todas las lineas. Guardad el resultado
  limpio en `results/Rno.PPI.tsv`
  SOLUCION: `sed '1 s/"//g;1 s/^/#/; s/uniprotkb://g' tmp/rat.mitab > results/Rno.PPI.tsv`

Para realizar el ejercicio 2 debemos conocer una caracteristica nueva del
comando `sed`, la posibilidad de elegir sobre que lineas se realiza la
sustitucion. Veamos el siguiente comando

`sed "1 s/hola/adios/"`

hemos añadido el numero `1` antes del patron de sustitucion, esto indica que
debe solo aplicarse a la linea 1. En el siguiente comando

`sed "/mundo/ s/hola/adios/"`

la sustitucion se hara solo sobre aquellas lineas que tambien contengan el
patron /mundo/. Para realizar los puntos (1) y (2) del ejercicio 2 lo mejor es
utilizar la opcion anterior, ya que sabemos que solo queremos alterar la
cabecera que esta en la linea 1.

El ejercicio 2 supone realizar 3 sustituciones. Esto lo podemos hacer con
tres comandos `sed` uno detras de otro, o concatenando todas las sustituciones
en un solo comando, separandolo por el caracter ';'

`sed "/mundo/ s/hola/adios/; 1 s/noche/dia/g; /lo tendre/ s/hoy/mañana/g"`

