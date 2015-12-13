Dotfiles: Ficheros de configuracion
===================================

Para los que os dediqueis a la programacion, y para todos los que useis linux
en general, es interesante mantener un directorio de "dotfiles". Se llaman
dotfiles por que en linux los ficheros de configuracion suelen estar en el
directorio del usuario y su nombre viene precedido de un punto ".", lo que los
hace ficheros ocultos. Normalmente viven en el directorio HOME del usuario,
pero la idea es ponerlos en el directorio de dotfiles y hacer un link symbolico
al directorio HOME.

La idea de la carpeta de dotfiles es que dediqueis tiempo a configurar vuestro
entorno de trabajo y que mantengais estas configuraciones agrupadas en un solo
directorio que podais mover de ordenador a ordenador y tener siempre con
vosotros a lo largo de vuestra carrera. Yo personalmente mantendo ademas de
configuraciones, scripts, alias de bash, templates de codigo, etc. Despues de
años de mantener este directorio ya dispongo de una configuraciones que me hace
mucho mas productivo. Lo ideal por supuesto es que este directorio lo tengais
subido a github o similar para que este accessible desde cualquier sitio.

Un tema relacionado con los archivos de configuracion son las librerias de
funciones. Mi modus operandi es:

* Cuando tengo un proyecto nuevo escribo el codigo necesario para completarlo
* Cuanto viene un nuevo proyecto y veo que parte de el codigo que necesito ya
  lo habia escrito antes, lo saco del proyecto anterior, lo meto en una
  libreria comun, y lo conecto desde el viejo y nuevo proyecto para compartir
  el codigo

Lo hago asi siguiendo dos principios: No tener codigo repetido y no hacer
sobre-ingenieria. Hay que encontrar un balance entre las dos.

La libreria comun la podeis mantener en cualquier sitio, pero quiza el
directorio de Dotfiles es un buen sitio para ponerlo. Lo importante es que
desde cualquier proyecto podais cargarlo por que sepais exactamente lo que hay
y donde.
