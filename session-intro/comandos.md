Repaso basico de uso de comandos
================================

La anatomia de una llamada tipica a comandos en Unix/Linux es:

`<path al ejecutable> <opciones> <parametros>`

por ejemplo:

`ls -la /tmp/`

El comando `ls` reside en `/bin/ls`. No hace falta poner el path entero
por que `/bin` esta en la variable de entorno `PATH`. Cuando se pone un comando
sin el path completo se busca en todos los directorios listados en `PATH` hasta
que se encuentra o se da error.

Las opciones contralan detalles de la ejecucion del comando. No todos los
comandos los tratan igual, pero en general siguen estas reglas:

* Existe una forma corta y una larga: -a es igual a --all. La forma corta solo
  tiene un guion, la larga dos.
* Varias opciones en forma corta se pueden agrupar tras un solo guion: El
  ejemplo anterior tambien podria haberse escrito `ls -l -a /tmp`
* Algunas opciones van solas mientras que otras tienen un valor asociado. Por
  ejemplo `grep -f mis_patrones.txt mi_fichero_de_interes`; en este caso la
  opcion -f tiene como valor 'mis_patrones.txt'

Los parametros consisten generalmente en los archivos con los que quieres
trabajar, `/tmp` en nuestro ejemplo. En Linux es comun que las opciones puedan
estar antes o despues de los parametros o entremezcladas, en Mac por ejemplo
muchos comandos no funcionan si pones las opciones al final.

Nota: es posible que los nombre usados, opciones y parametros, no sean siempre
las que encontreis. Lo importante es que entendais la diferencia entre ambas.
