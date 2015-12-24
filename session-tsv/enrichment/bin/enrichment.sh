#!/bin/bash

# Tomamos los parametros de entrada del script: $1, $2, $3, ...
gene_file=$1

# Obtenemos el directorio raiz del projecto. $0 es el path al script que se
# ejecuta, es decir este. El comando `dirname` obtiene el directorio que lo
# contiene, es decir `bin`. Con los dos puntos vamos al directorio anterior,
# es decir, el directorio raiz del proyecto (root en ingles)
root=`dirname $0`/..

# Construimos los paths para los ficheros que vamos a leer o escribir.
# Empezamos definiendo los directorios `data`, `var` y `tmp`. Luego definimos
# los ficheros que necesitamos
data_dir=$root/data
var_dir=$root/var
tmp_dir=$root/tmp

go_file=$data_dir/gene_go_bp
pos_file=$data_dir/gene_positions

blacklist=$var_dir/blacklist
clean_go=$var_dir/gene_go_bp_clean
all_terms=$var_dir/all_terms
term_counts=$var_dir/term_counts

matches=$tmp_dir/matches.$RANDOM
matched_terms=$tmp_dir/matched_terms.$RANDOM

# Creamos los directorios si no existen. El test es `-d` que es exitoso si el
# path suministrado existe y es un directorio. Con `!` negamos el test. Lo que
# hacemos si no se cumple `-d` es crear el directorio con `mkdir`

if [ ! -d $data_dir ]; then
  mkdir $data_dir
fi

if [ ! -d $var_dir ]; then
  mkdir $var_dir
fi

if [ ! -d $tmp_dir ]; then
  mkdir $tmp_dir
fi

# Creamos un fichero con la 'lista negra', si no existe (con `-e` en lugar de
# `-d`, por que no tiene que ser un directorio). Estos son genes que no estan
# en chromosomas `buenos` (los cromosomas 'malos' son parches y correcciones y
# tienen nombre raros como HG174_HG254_PATCH). Usamos el fichero de posiciones, que tiene
# como primera y segunda columna el gen y el cromosoma donde esta. Cortamos la
# primera y segunda columna con `cut`, ya que son las que nos interesa. Usamos
# `grep` para quitar las lineas que tienen cromosomas 'buenos' (1, 2, 3, ...,
# X, Y). Una vez que nos quedamos con las lineas que contienen solo genes en
# cromosomas males, cortamos la primera columna para quedarnos solo con los
# genes y lo guardamos en el fichero.

if [ ! -e $blacklist ]; then
    cut -f 1,2 $pos_file |grep -Pv 'ENSG\d*\s[xy0-9]{1,2}'|cut -f 1 > $blacklist
fi

# Utilizamos el fichero de lista negra para quitar las lineas que contengan
# genes malos del fichero de asociaciones entre genes y terminos de GO.
# Guardamos el resultado en su fichero correspondiente
if [ ! -e $clean_go ]; then
    grep -v -F -w -f $blacklist $go_file > $clean_go
fi

# Obtenemos una lista con todos los terminos GO que aparecen associados a
# nuestros genes. Primero tomamos el fichero de asociacion genes-GO (la version
# limpia de genes malos) y le cortamos la segunda columna (la de terminos GO,
# la primera es la de genes). Como cada gen puede estar asociados a varios
# terminos, estos aparecen separados por `|`, asi que usamos `tr` para cambiar
# este caracter por un salto de linea `\n`. Usamos `grep` para eliminar lineas
# vacias, y finalmente `sort -u` que ordena pero tambien quita repeticiones. El
# comando `tr` que usamos aqui se puede sustituir por `sed`, pero es mas facil
# usar `tr` para estas cosas.
if [ ! -e $all_terms ]; then
    cut -f 2 $clean_go | tr '|' '\n' | grep GO |sort -u > $all_terms
fi

# Utilizamos la construccion `for` de `bash` para repetir el mismo proceso por
# cada termino GO. La sentencia `cat $all_terms`, que escribiria todos los
# terminos por pantalla en este caso se los pasa a `for` para que los asigne a
# la variable `$t` uno en cada iteracion. Para contar cuantos genes tienen ese
# termino utilizamos de nuevo `grep`, que nos mostrara solo las lineas
# correspondientes a genes que tengan este termino asignado. Contando el numero
# de lineas con `wc -l` nos dice por tanto el numero de genes que hay. Vamos
# metiendo una linea por cada termino en el fichero final utilizando `echo`,
# esta linea contiene en termino GO y en numero de genes que tiene asignados.
# El comando `echo` escribe por STDOUT la cadena de text que le pases, que como
# veis tiene el termino `$t` y el numero de genes `$count` (ambas son variables
# que se sustituyen en la cadena de texto por el valor que les corresponde en
# cada iteracion)
if [ ! -e $term_counts ]; then
    for t in `cat $all_terms`; do
        count=`grep $t $clean_go | wc -l`
        echo "$t	$count" >> $term_counts
    done
fi

# Este comando extrae del fichero (limpio) de genes-GO las lineas que
# corresponden a nuestros genes de entrada y lo guarda en el fichero
# correspondiente
grep -w -F -f $gene_file $clean_go > $matches

# Obtenemos los terminos que estan asociados a *alguno* de nuestros genes. Lo
# hacemos cortando la segunda columna y sustituyendo `|` por `\n` como haciamos
# antes. Estos son nuestros terminos de interes, y entre los que queremos
# encontrar cuales estan sobre-representados o enriquecidos
cut -f 2 $matches | tr '|' '\n' |grep GO |sort -u > $matched_terms

# Contamos el numero de genes que hemos puesto de entrada, asi como el numero
# de genes con asociaciones a terminos GO que tenemos en total (despues de quitar genes 'malos')
num_genes=`cat $gene_file|wc -l`
num_genes_all=`cat $clean_go|wc -l`

# Aqui es donde realizamos el calculo del enriquecimiento utilizando los
# recursos que hemos preparado. Iteramos los terminos de interes. Para cada uno
# calculamos el numero de nuestros genes que estan anotados con ese termino. Si
# no son 3 o mas `-ge 3` no hacemos nada, pero si lo son calculamos el valor de
# la estadistica de enriquecimiento utilizando R. Esta estadistica necesita de
# 4 numeros: el numero de nuestros genes anotados con el termino (`$count`),
# todos los genes del genoma anotados con el termino (`$all_counts`), el numero
# de genes del genoma que no estan anotados con el termino (`$rest`), y el numero
# total de nuestros genes (`$num_genes`). El comando de bash `$(())` se usa
# para realizar una operacion aritmetica, en este caso una resta. Para realizar
# el calculo final mandamos a R la linea conteniendo la funciona a evaluar.
# Esta linea la construimos con `echo`, como haciamos antes, y se la mandamos a
# `R --slave` (la opcion `--slave` se usa para que R sepa que no tiene que
# abrir una sesion interactiva, sino ejecutar lo que le mandan directamente).
# Lo que viene despues es simplemente para limpiar un poco la salida de `R` y
# obtener el p-valor. El resultado lo escribimos por STDOUT utilizando `echo`

echo "#Termino GO	Genes nuestos con termino	Total genes con termino	Total genes sin termino	Total de nuestros genes	P-valor"
for t in `cat $matched_terms`; do
    count=`grep $t $matches|wc -l`
    if [ $count -ge 3 ]; then
        all_counts=`grep $t $term_counts|cut -f 2`
        rest=$(( $num_genes_all - $all_counts ))
        pvalue=`echo "phyper($count - 1, $all_counts, $rest, $num_genes, F)" | R --slave|grep "[1]"|sed 's/.* \([0-9\.]\+\).*/\1/'`
        echo "$t	$count	$all_counts	$rest	$num_genes	$pvalue"
    fi
done

# Borramos los ficheros temporales
rm $matches $matched_terms
