Uso de grep
===========

El comando `grep` es quiza uno de los mas utiles y sencillos de usar. Para los
usuarios de Unix/Linux es ya como un verbo: "Grep the files for lines including
XXX".

Como todos los buenos comandos en linux sigue la filosofia de hacer una sola
cosa pero hacerla muy bien. La cosa que hace es filtrar las lineas de un
fichero (o stream) comprobando si cumplen cierto patron. El patron se define
utilizando una cosa llamada `expresiones regulares`. Las expresiones regulares
es otro de los pilares del procesamiento de datos. Su conocimiento es clave
para muchas tareas.

Conceptos basicos de RegExp:

* Los patrones incluyen texto que debe encontrarse en la linea
* Existen caracteres especiales que representan cosas como el principio de
  linea `^`, final de linea `$`, cualquier caracter `.` (el punto se pone
  `\.`), repeticiones de lo anterior `+` (e.g. el patron `ab+c` buscara lineas
  que contengan cosas como "abbbbbbbbc", etc
* Se pueden expecificar conjuntos de caracteres como digitos `\d`, espacios
  `\s`, letras normales `\w`, etc. O definidos ad-hoc `[-:;]`, que incluiria
  los caracteres: '-', ':' y ';'
* Toda una expresion regular se puede hacer 'case-insensitive' es decir, que
  ignore mayusculas. Recordad que a diferencia de Windows, Unix considera que
  las letras 'a' y 'A' son absolutamtente distintas, a no ser que se le
  indique lo contrario.

Desgraciadamente existen dos formatos para expresiones regulares, las
originales del shell y las de Perl. Las de Perl son las mas modernas y las que
practicamente todos los lenguages de programacion usan, las originales de shell
son unas mas pesadas de usar pero que usan caracteres mas neutros para la linea
de comandos. Por ejemplo, para representar digitos en el formato Perl se hace
`\d`, mientras que en el formato original de la shell se pone `[[:digit:]]`.
Con la opcion `-P` de `grep` se le puede indicar que interprete los patrones
con el formato Perl, en lugar del original. Hay mucho mas que aprender sobre
expresiones regulares: captura de grupos, condiciones mas complejas, etc.
Veremos algo mas cuando entremos en `sed`

* Ejercicio 1: Utilizar grep para buscar aquellas mutaciones donde el
  allelo mutante sea "T". Es decir, lineas que incluyan una "T". 
  SOLUCION: `grep ":T$" ejemplos/mutaciones`

* Ejercicio 2: Utilizar grep para buscar aquellas mutaciones donde el
  chromosoma sea "10". Es decir, lineas que incluyan "10:". Para evitar que
  encuentre lineas como esta "2:111111110:T" tenemos que especificar que el
  patron "10:" ocurra al principio de la linea.
  SOLUCION: `grep "^10:" ejemplos/mutaciones`

* Ejercicio 3: Utilizar grep para buscar aquellas mutaciones donde el
  chromosoma NO sea "10". Para esto hay que usar una opcion de `grep` para que
  invierta el filtrad
  SOLUCION: `grep -v "^10:" ejemplos/mutaciones`

Los siguientes ejercicios fueron tomados de
[aqui](http://evc-cit.info/cit052/grep1.html). Trabajaremos con el fichero
`ejemplos/grepdata.txt`

Algunas cosas mas que debeis de saber son:
 
* Como mencione antes, se pueden especificar repeticiones de parte de un
  patron. Hemos visto el modificador `+` que significa "una o mas
  repeticiones". El modificador `*` significa "ninguna, una o mas". Para un
  numero concreto de repeticiones se puede hacer `\{3\}` o usar un rango `\{3-10\}`.
  Los caracteres `{` y `}` hay que escaparlos con `\` para que se reconozcan
  para esta tarea.

* Se pueden hacer sub-patrones dentro de un patron, y estos se pueden repetir o
  volver a especificar mas adelante. Por ejemplo la expresion `\(aba\)+cd` se
  complira en cadenas como "abaabaabaabacd". El sub-patron dentro de los
  parentesis se llama un "grupo" y la parte que encaja con el sub-patron se
  dice que es "capturado por el grupo". La parte capturada por el grupo se
  puede volver a referenciar con al numero de grupo. En el ejemplo anterior
  solo hay un grupo, el 1, que captura la cadena "abaabaabaaba". En este otro
  ejemplo `\(\d+\):\1` buscamos uno o mas digitos que se repiten separados por
  un ":", un ejemplo que satisface el patron es "1234:1234", tambien este lo
  satisface "123456:456".

* Vimos que podemos especificar un grupo de caracteres ad-hoc, por ejemplo
  `[aeiou]`. Tambien podemos definir el grupo contrario, es decir, todos los
  caracteres que no estan contenidos en la lista, por ejemplo `[^aeiou]`

* Podemos pedir a `grep` que cuando encuentre una linea que cumpla un patron no
  muestre la linea entera sino solo el fragment que cumple el patron, con la
  opcion `-o`

Aqui van algunos ejercicios mas

* Ejercicio 4: Muestra todas las lineas que tengan un numero de telefono con
  extension (letra x o X seguido de 4 digitos)
  SOLUCION: `grep "[xX][[:digit:]]\{4\}" ejemplos/grepdata.txt`

* Ejercicio 5: Muestra todas las lineas que comiencen por 3 digitos y un
  espacio (utilizad `\{\}`)
  SOLUCION: `grep "^[[:digit:]]\{3\} " ejemplos/grepdata.txt`

* Ejercicio 6: Muestra todas las lineas que contengan un año (suponed que es
  despues del 2000)
  SOLUCION: `grep "2[[:digit:]]\{3\} " ejemplos/grepdata.txt`

* Ejercicio 7: Muestra todas las lineas que NO comiencen por la letra mayuscula
  "S"
  SOLUCION: `grep -v "^S" ejemplos/grepdata.txt`

Los siguientes ejercicios requieren que especifiques alguna opcion particular
para `grep`

* Ejercicio 8: Muestra las lineas que contengan "CA", tanto en mayusculas como
  en minusculas
  SOLUCION: `grep -i "CA" ejemplos/grepdata.txt`

* Ejercicio 9: Muestra las lineas que contengan una direccion de email,
  listando el numero de la linea
  SOLUCION: `grep -n "@" ejemplos/grepdata.txt`

* Ejercicio 10: Muestra las lineas que NO contengan el texto "Sep."
  SOLUCION: `grep -v "Sep\." ejemplos/grepdata.txt`

* Ejercicio 11: Muestra lineas que contengan la palabra _completa_ "de"
  SOLUCION: `grep -w "de" ejemplos/grepdata.txt`



