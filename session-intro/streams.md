Ficheros y Streams
==================

Un fichero es una secuencia de bytes, en el caso de un fichero de texto, estos
bytes representan caracteres. Cuando abris un fichero con el editor este lo
edita todo de golpe, pero amenudo se pueden abrir los ficheros en forma de
`stream`, que consiste en que los caracteres del fichero van saliendo uno de
tras de otro. 

Todos los programas de linux tienen 3 streams abiertos por defecto: STDIN,
STDOUT y STDERR (standard-in, standard-out y standard-error). El primero de
ellos es un stream del que solo puede leer caracteres, los otros dos son
streams sobre los que puede escribir catacteres. Normalmente STDIN es para
scribir el resultado de ejecutar el programa y STDERR es para logs, mensajes de
error, etc. Cuando correis un programa desde la linea de comandos generalmente
STDIN esta asociada al teclado mientras que STDOUT y STDERR se vuelcan a la
terminal y sus mensajes salen de forma entrelazada.

Una de las cosas mas utiles que tiene Unix/Linux es precisamente este
paradigma, que permite que un proceso escriba su salida en STDOUT y que esta
este conectada al siguiente proceso. De esta forma los resultados del primer
proceso van siendo procesados por el segundo segun van siendo disponibles. A
esto se le llama un `pipe` o una tuberia.

Muchos programas de Unix/Linux funcionan leyendo y escribiendo en los streams a
nivel de lineas, no de caracteres. Por ejemplo, el programa `ls` lista los
ficheros de un directorio por STDOUT uno por linea, esto se puede mandar por un
pipe al comando `grep` que filtrara las lineas que lee por STDIN y volvera a
escribir por STDOUT solo las que cumplan con cierto patron que le
especifiquemos.

El procesamiento linea a linea es fundamental para muchas tareas con volumenes
grandes de datos. Por ejemplo, un programador novato estara tentado a leer un
fichero entero en memoria para trabajar con el cuando en realidad a menudo
podria leer y procesar el fichero linea a linea, sin tener que cargarlo en
memoria. De esta forma, no solo la memoria no se llena con archivos grandes,
sino que el resultados va apareciendo inmediatamente segun se va leyendo el
archivo, y este asi puede empezar a ser procesado tambien inmediatamente por el
siguiente proceso.
