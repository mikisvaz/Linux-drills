Directorio de Proyecto
======================

Es importante aprender a organizar vuestros ficheros de trabajo. Estos ficheros
pueden ser cosas como: scripts con codigo, ficheros con datos, resultados de
analisis, textos de documentacion, versiones antiguas de scripts, etc. Una de
las primeras cosas que debeis aprender es a organizar estos ficheros. Cada uno
de nosotros tiene un sistema particular, aqui or propongo el mio.

Yo sigo mas o menos la nomenclatura de Unix/Linux:

* `src`: carpeta con codigo fuente de un programa. Como hago sobre todo scripting no lo uso
  mucho
* `bin`: carpeta con scripts y programas ejecutables
* `lib`: librerias de funciones que son usadas por los scripts de `bin`
* `data` o `share`: carpeta con ficheros de datos
* `results`: Carpeta con los resultados de analisis
* `tmp`: Ficheros temporales que no pasa nada si se borran
* `var`: Ficheros "variables". Yo lo uso para poner indices, caches, etc
* `doc`: Ficheros con documentacion
* `README`: Fichero con descripcion del proyecto, ayuda, etc
* `LICENSE`: Fichero con la licencia del proyecto 

Es buena idea usar `git` en todos vuestros proyectos, aunque no lo subais a
`github`. No cuesta nada usarlo y teneis un historico de cambios. Es posible
que querais omitir del repositorio ficheros temporales o variables, o algunos
ficheros de datos si son muy grandes.

Ademas de estos directorios yo utilizo dos mas. Estos directorios los creo en
cualquier sitio, no necesariamente en el directorio raiz del proyecto.

* `.save`: Directorio oculto con versiones viejas de cosas. Las pongo ahi
  cuando no sirven pero quiero tenerlas a mano por si acaso.
* `.crap`: Directorio oculto con versiones viejas de cosas. En este caso son
  cosas que casi seguro que no quiero y que no pasa nada si las borro

