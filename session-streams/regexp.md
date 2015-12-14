Expresiones regulares
=====================

Las expresiones regulares son una de las herramientas mas importantes para el
analista de datos. No son algo que se use realmente durante el propio analisis,
sino mas bien para preparar los datos para el analisis.

La idea de las expresiones regulares es expresar un patron, una regla, que
encaje justo con el texto que deseamos encontrar. Al encajar el patron al texto
podemos ademas recuperar (o capturar) sobre la marcha fragmentos concretos que
podemos usar mas adelante; despues de encajar el patron o incluso mas adelante
en el patron mismo.

Para escribir una expresion regular que encaje con el texto que quereis lo
habitual es tomar un texto de ejemplo e ir escribiendo la expresion poco a poco
hasta que el texto es correctamente capturado. Despues se pueden probar un par
de ejemplos mas y cuando estemos seguros de que esta lista la aplicamos a
nuestro texto de interes. Las expresiones regulares tambien se pueden usar en
la funcion de busqueda de muchos editores, especialmente Unix/Linux.

Debajo os dejo algunos recursos de interes. Os aconsejo que leais el primer
tutorial y tengais disponible la chuleta. Para el que quiere probar un poco
para afianzar conocimientos puede utilizar el tutorial interactivo.

  * [Aqui](http://boozox.net/php/manual-completo-y-sencillo-de-expresiones-regulares-en-php/)
    encontrareis una introduccion en español. Aunque es para Php, hasta la
    cabecera 'Las funciones', es sobre regexp en general.
  
  * [Este documento](http://www.cheatography.com/davechild/cheat-sheets/regular-expressions/pdf/)
    es una chuleta con los componentes mas habituales de la expresiones
    regulares.
  
  * [Aqui](http://regexone.com/) podeis encontrar un tutorial interactivo.

Hay que tener en cuenta que si bien lo que habreis aprendido en estos
tutoriales corresponde a las expresiones regulares modernas, las que todos los
lenguajes de programacion entienden, las que se usan en comandos como `grep` y
`sed` son una version algo anterior con algunas diferencias. La diferencia
principal esta en el uso de 'grupos de caracteres', donde `\d` se usa para
decir 'digito' en las expresiones regulares modernas mientras que sed y grep
usan '[[:digit:]]', y tambien algunos modificadores como el `+` que significa
uno o mas y que en `sed` y `grep` o no existe o hay que escaparlo. Hay algunas
funcionalidades avanzadas que tampoco estaran disponibles, como las algunos
asertos y condiciones. Lamento que esto sea asi, pero asi es. Mi consejo es
que aprendais las expresiones regulares modernas, pero que sepais que cosas hay
que cambiar para que funciones con los comandos basicos de linux.
