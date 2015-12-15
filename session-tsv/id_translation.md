Traduccion de identificadores
=============================

Vamos a resolver un pequeno caso de uso que ilustra el uso de `grep`, `sed`,
`cut` y otras comandos basicos de Unix/Linux. Se trata de tomar una lista de
genes dado en cualquier formato y traducirlos a otro formato concreto.

Recursos
--------

Disponemos de una tabla obtenida de Ensembl BioMart con todos los
identificadores que usaremos. Como vimos en la seccion anterior, algunos
genes son problematicos, ya que residen en cromosomas especiales y pueden
confundir la traduccion. Para resolver este problema tenemos un fichero de
posiciones de genes, tambien obtenido de Ensembl BioMart.

Metodologia
-----------

Vamos a generar un proyecto con un binario que tomara como parametros un
fichero con los genes que queremos traducir y el formato destino. Para
realizar el mappeo de identificadores utilizaremos grep, pero antes debemos
preparar los ficheros para poder realizarlo. 

El proceso consiste en mapear los genes primero a `Ensembl Gene ID` y luego al
formato que sea. Para ello necesitamos un indice para cada paso. Estos indices
deben estar filtrados de antemano para no incluir los genes problematicos.

En el script `bin/translate.sh` habra los siguientes pasos:

* Determinar los paths de los ficheros que necesitamos: indice para tranducir a
  ensembl e indice para traducir al formato final. Tambien necesitaremos el
  fichero de genes problematicos para eliminarlos de los indices
* Crear estos ficheros si no estan ya disponibles
* Utilizar el fichero de indice a Ensembl para el primer paso de traduccion
* Utilizar el fichero de indice a nuestro formato destino para realizar el
  segundo paso de traduccion

Examinaremos el proyecto tal cual esta para entender su funcionamiento. 

Ejercicios
---------

* Ejercicio 1: altereis la salida para que no solo salgan los genes traducidos
  sino la correspondencia entre original y traduccion

El problema es que al mapear con el indice original, el orden de los genes de
entrada puede ser alterado. Debemos conseguir restablecer el orden entre
resultado y entrada. El secreto es reordenar la entrada de la misma forma que
la salida tras el primer paso de traduccion; para esto buscaremos de nuevo la
entrada en el indice con `grep -o` para obtenerla en el mismo orden.

* Ejercicio 2: Un posible problema que tenemos es que si el mismo script se
  ejecuta varias veces es posible que los ficheros temporales se pisen. Vamos a
  asegurarnos de que esto no pasa utilizando nombre unicos. Esto lo haremos
  utilizando la variable de entorno `RANDOM` para obtener un nombre aleatorio.
  Despues limpiaremos los ficheros temporales

