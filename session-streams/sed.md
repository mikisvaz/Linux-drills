Uso de sed
==========

El programa `sed` esta orientado a lineas, como grep, pero en este caso para
editar y modificar las lineas en lugar de simplemente para editarlas.

Sed es un programa tremendamente versatil y potente, aunque la mayoria de
nosotros tan solo hagamos uso de una pequeña parte. En esta seccion tratare de
presentar solamente el uso mas comun y sencillo. Un buen tutorial lo podeis
encontrar (aqui)[http://www.grymoire.com/Unix/Sed.html#uh-0]

El principal uso que tiene es el de la sustitucion, que en sed se denota como
's'. Empezemos con un ejemplo:

`sed s/hola/adios/` 

El comando de arriba tomara las lineas de la STDIN y las escribira por STDOUT
tras sustituir la primera ocurrencia del texto 'hola' por el texto 'adios'. La
anatomia de este comando es la siguiente. La `s` inicial indica que vamos a
hacer una sustitucion, esta sustitucion esta compuesta de dos partes,
delimitadas por el caracter `/`; la primera es una expresion regular que encaje
con el texto a remplazar, y la segunda es el texto que usaremos para
remplazarlo. Si nuestra expresion regular o el texto de sustitucion contiene el
caracter `/` deberemos escaparlo para que no confunda al comando `\/`

Es habitual poner comillas a la parte de la sustitucion `sed 's/hola/adios/'`.
Tambien es comun especificar el fichero sobre el que queremos trabajar en lugar
de utilizar la STDIN.

El ejemplo anterior solo cambiara la primera ocurrencia. Sed acepta algunos
modificadores a los patrones, como la `g` que indica que se hagan todas las
sustiticiones posibles.

`sed "s/hola/adios/g"` 

Tambien se puede indicar una ocurrencia concreta, como la segunda, poniendo `2`
en lugar de `g`, aunque yo jamas la he usado.

Como todo en Unix/Linux, las mayusculas y las minusculas son caracteres
distintos. Si quieremos que `sed` los trate como iguales podemos usar el
modificador `I`

`sed "s/hola/Adios/Ig"` 

La `I` mayuscula es un poco una excepcion, la mayoria de las implementaciones
de expresiones regulares la usan en minusculas `i`

Como ocurria con grep, uno puede crear grupos para capturar sub-patrones y
usarlos mas adelante, en concreto en la parte del texto de sustitucion.

`sed 's/\([a-z]+\).*/\1/'`

El comando anterior tomara la primera palabra que encuentre (una o mas letras
entre 'a' y 'z') y la asignara a la primera captura, el resto de caracteres
(especificado como cualquier caracter `.` repetido las veces que sea `*`)
tambien forma parte del patron y sera sustituido. El texto que se usara para
sustituirlo todo sera el texto de la primera captura. Por ejemplo la linea
"hola mundo" se convertira en "hola". Esta expression regular no tiene en
cuenta que puede haber espacios vacios al principio de la linea por lo que la
linea "   hola mundo" se convertira en "    hola". Para evitar este
comportamiento debemos contemplar tambien esta situacion

`sed 's/\s*\([a-z]+\).*/\1/'`


