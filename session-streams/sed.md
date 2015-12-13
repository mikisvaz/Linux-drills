Sed
===

El comando `sed` es un comando orientado a lineas, como lo es `grep`. El
objetivo de `grep` es buscar lineas que cumplan un patron, mientras que el
objetivo de `sed` es procesar lineas para sustituir unos patrones por otros.
Al menos este es el objetivo mas habitual. En realidad `sed` es un programa
mucho mas potente y versatil de lo que mucho sabemos en la practica. Aunque hay
mucho mas de lo que voy a contaros en esta clase, lo que si vamos a cubrir es
en general suficiente, asi que comencemos. Para un repaso mas completo del
programa podeis acudir (aqui)[http://www.grymoire.com/Unix/Sed.html]

La funcionalidad central de sed es la de "sustitucion". Un comando de
sustitucion en `sed` tiene este aspecto

`sed "s/hola/adios/"`

En este caso `sed` leeria lineas de STDIN y las escribiria por STDOUT tras
realizar la sustitucion. La sustitucion en cuestion esta definida por el
parametro `s/hola/adios`. La `s` inicial indica que en efecto estamos pidiendo
que haga una sustitucion. Los caracteres `/` delimitan las dos partes de la
sustitucion: el patron que se busca (hola), y el texto con el que reemplazarlo
(adios). La ejecucion concreta de este comando buscara la primera ocurrencia
del texto 'hola' (por cada linea) y la sustituira por 'adios'.

`sed "s/hola/adios/g"`

Este comando es similar, pero en este caso la sustitucion buscara y sustituira
todas las ocurrencias del texto 'hola' en lugar de solo la primera. Este
comportamiento esta dado por el modificador `g` al final del parametro de
sustitucion.  Otro modificador comun es `I` que indica que la sustitucion
ignore la diferencia entre mayusculas y minusculas (case Insensitive, donde
'case' viene de uppercase y lowercase): `sed "s/hola/adios/gI"`

Como en el caso de `grep` no es necesario leer la entrada de STDIN, sino que se
puede poner el nombre de un archivo. Tambien es posible, como siempre en
Unix/Linux, redirigir la salida a otro fichero

`sed "s/hola/adios/g" fichero_entrada.txt > fichero_salida.txt`

La gracia de `sed` esta por supuesto en las expresiones regulares. Consideremos
este ejemplo:

`sed "s/[0-9]\+:[0-9]\+//g"`

El texto que buscamos esta compuesto de uno o mas digitos ([0-9]\\+; el `+` hay
que escaparlo) seguido de el caracter ':' y de uno o mas digitos. Cualquier
ocurrencia de este patron es reemplazado por la cadena vacia; es decir, es
eliminado. En este ejemplo hemos visto como podemos tener flexibilidad en el
patron que queremos buscar. Veamos este otro ejemplo:

`sed "s/\([0-9]\+\):\([0-9]\+\)/\1-\2/g"`

El patron que buscamos es basicamente el mismo, solo que ahora hemos puesto
unos parentesis (escapados con '\') rodeando al primer y segundo conjunto de
digitos. Estos parentesis se denominan 'grupos', y el texto que encaja en cada
uno se dice que esta 'capturado por el grupo'; es decir, pedimos a `sed` que
recuerde que parte del texto encaja con cada grupo. En la segunda parte del
comando, el que contiene el texto que se usara para reemplazar, utilizamos este
texto capturado. Los caracteres `\1` y `\2` corresponden al texto capturado por
los grupos uno y dos respectivamente. El resultado de este comando es que una
linea como

"Mientras escribo esto son las 17:40"

en esta

"Mientras escribo esto son las 17-40"

La syntaxis que tienen las expresiones regulares intimida bastante a los
que las ven por primera vez; son secuencias a menudo largas de caracteres
incomprensibles a primera vista. Hace falta algo de experiencia para 
familiarizarse con ellas, pero no es dificil. Y creo que son mas faciles
de escribir que de leer.

El comando `sed` ofrece una forma muy sencilla y potente de manipular el
contenido de un fichero para, por ejemplo, poder ponerlo en un formato mas
facil de procesar con R u otros scripts o para extrear la parte interesante del
fichero. 

Lo que hemos visto hasta ahora da una buena idea de como funciona `sed`. En lo
que queda de esta seccion vamos a profundizar en el comando de sustitucion de
para entender su versatilidad.

`sed "s/^ *\([[:alpha:]]\+\).*/\1/"`

El comando anterior buscara lineas que comiencen (^) por 0 o mas espacios ('
*') seguido de uno o mas caracteres alfanumericos ([[:alpha:]]\+), que
capturamos, y seguido de cualquier secuencia de catacteres (.*). Es decir,
sustituira cualquier linea por su primera palabra. Por ejemplo

"    Aqui empieza mi linea"

por

"Aqui"

Sin embargo este comando

`sed "s/^ *\([[:alpha:]]\+\).*/\1/"`

carece de la parte final (.*), por lo que esta no se considerara en la
sustitucion, siendo el resultado final

"Aqui empieza mi linea"

Hemos visto como `\1` y demas pueden usarse para acceder al texto capturado 
por cada grupo. Tambien existe la posibilidad de acceder al todo el
texto capturado por el patron de busqueda con el caracter `&`. Por ejemplo

`sed "s/[0-9]\+:[0-9]\+/(&)/"`

tomara el patron encontrado y lo rodeara de parentesis.


Vamos a realizar algunos ejercicios. Los he tomado de la (siguiente
pagina)[http://castilloinformatica.com/wiki/index.php?title=Ejercicios_de_sed]

* Ejercicio 1- Modifica la IP de un ordenador por la dirección de la red. (por
  ejemplo de 192.168.3.5 a 192.168.3.0)

* Ejercicio 2- Cambia del PATH, el /usr/bin por /home/lliurex/bin

* Ejercicio 3- Pon una palabra determinada entre comillas

* Ejercicio 4- Pon una coma entre la primera palabra y las demás de una línea:

* Ejercicio 5- Convierte 123456789abc en una dirección MAC (12:34:56:78:9a:bc)

* Ejercicio 6- De todas las líneas de /etc/passwd, muestra el directorio home y
  luego el nombre (¡feo! Mañana aprenderemos a hacerlo mejor)

* Ejercicio 7- Transformar el fichero 'ejemplos/biblio.txt' para que quede como
  en 'ejemplos/biblio2.txt' (¡dificil!)


