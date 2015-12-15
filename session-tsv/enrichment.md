Traduccion de identificadores
=============================

En este caso vamos a hacer una pequeña funcionalidad de enriquecimiento de
genes. El procedimiento es parecido al anterior, con la novedad de que haremos
una llamada a R para obtener los p-valores

Recursos
--------

Disponemos de la lista de terminos GO (solo biological process) asociados a
cada gen en `data/gene_go_bp`. Tambien tenemos las posiciones de genes para
filtrar aquellos problematicos, igual que haciamos antes.

Metodologia
-----------

Prepararemos el fichero de asociacion de go tras filtrar los gene
problematicos. Despues debemos preparar un fichero con todos los terminos GO
presentes, y otro que asocie a cada termino GO el numero de genes que
pertenecen a el.

El analisis en si consiste en asociar los genes de la entrada a terminos GO y
para cada uno llamar a R para comprobar como de significativo es el numero de
genes de la entrada asociadedos al termino teniendo en cuenta el numero total
de genes en la entrada, en numero total de genes en el dataset, y en numero
total de genes en el dataset asociados a ese termino

Ejercicios
---------

* Ejercicio 1: Nuestra salida muestra solo los terminos GO por identificador.
  Seria util tambien mostrar el nombre. Bajad la asociacion de terminos GO y
  nombre de biomart y modificad en script para añadir estos nombres a la salida
  utilizando `join`
