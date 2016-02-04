Ficheros TSV
============

Los ficheros TSV se llaman asi por que son ficheros de campos separados por
tabulador (tab separated value files). De los muchos formatos posibles de
fichero esta es con diferencia en mas versatil por la facilidad que tienen para
ser procesados, a diferencia de otros formatos como XML. Otro formato parecido
es el CSV (comma separated value files), donde en lugar de tabulador se usa una
coma `,`. Los ficheros CSV ademas tienen cada uno de los campos rodeados de
comillas, para asi no confundir las comas que haya dentro de uno de los campos
con las comas que se usan para dividir campos. En el fichero TSV no se incluyen
las comillas para delimitar campos, ya que estos raras veces incluiran un
tabulador. Los TSV son por lo tanto preferibles a los CSV.

La informacion en los ficheros TSV suele representar en cada linea una
'entidad', por ejemplo un gen. El primer campo suele ser el codigo que
identifica a la entidad, por ejemplo el nombre del gen (e.g. TP53), o un
identificador de base de datos (e.g. ENSG00000141510). El resto de campos
describen 'propiedades' (en el sentido mas generico) de estas entidades. Por
ejemplo en el fichero `data/gene_positions` encontrareis para cada gen 4 campos
describiendo el chromosoma en que habita, la hebra que lo codifica,  y las
coordenadas de principio y fin. 

En ocasiones una entidad no tiene un valor unico para una propiedad, sino una
lista de ellos; en este caso se separan los distintos valores con el caracter
`|`. Por ejemplo en el fichero `data/identifiers` encontraremos para cada
identificador de gen en formato Ensembl (e.g. ENSG00000141510) los
identificadores equivalentes en otros formatos. La correspondencia entre
identificadores desgraciadamente no es uno-a-uno en muchos casos, asi que las
diversas opciones las podemos encontrar separadas por `|`. 

En vista de estas consideraciones yo encuentro que hay 4 tipos de ficheros TSV

 * Lista: varios campos por linea, cada uno con un solo valor posible
 * Doble: varios campos por linea, cada uno posiblemente con mas de un valor
 * Simple: un unico campo por linea, un unico valor del campo
 * Plano: un unico campo por linea, con posiblemente varios valores. A
   diferencia del tipo "doble" los distintos valores se separan tambien por
   tabulador, en lugar de por `|`

La mayoria de ficheros que encontreis seguira uno de estos formatos. Lo mas
comun es que la primera linea del fichero describa los campos que hay. De nuevo
existen algunos formatos ligeramente distintos para esta cabecera. El mas comun
es que haya una cabecera por cada campo y que la linea comience con el caracter
"#". Puede haber cualquier numero de lineas anteriores a la cabecera siempre y
cuando comiencen por "#", la cabecera es siempre la ultima de estas lineas

Algunos ficheros no incluyen el caracter "#" y el usuario debe tener cuidado de
tratar la primera linea como una cabecera y no como una linea de datos.
Finalmente R acostumbra a guardar estos ficheros omitiendo la descripcion del
primer campo, que es digamos el de identificador de entidad.

* Ejercicio 1: He creado un alias llamado `numera_tabs`. Para cargar el alias
  debeis ejecutar el script `bin/set_alias.sh`. Usad `numera_tabs` para
  explorar el fichero `data/identifiers`. Idenfiticad las columnas con
  identificadores de Ensembl y con nombre de genes. Luego utilizad el comando
  `cut` para extraer esos campos a un fichero llamado `results/gene_names`.
  SOLUCION: `source bin/set_alias.sh; numera_tabs data/identifiers | head -n 2; cut -f 1,4 data/identifiers > results/gene_names`

* Ejercicio 2: Utilizad `grep` y `cut` para transformar la lista de genes en
  `data/wnt_genes` a format Ensembl. Pista: con `grep` debeis usar el fichero
  de genes como la lista de patrones a usar `-f <fichero>` estos patrones deben
  de ser encontrados tal cual y como palabras enteras `-F -w`, finalmente
  utilizad `cut` de nuevo para quedaros con el campo de Ensembl.
  SOLUCION: `grep -F -w -f data/wnt_genes results/gene_names | cut -f 1`

* Ejercicio 3: Comprobad que en numero de genes en Ensembl es igual al numero
  de genes original. No lo es! tratad de averiguar por que
  SOLUCION: `wc -l data/wnt_genes; grep -F -w -f data/wnt_genes results/gene_names | cut -f 1 |wc -l`

* Ejercicio 4: Para arreglar el problema anterior, eliminad aquellos genes que
  estan asignados a chromosomas 'no-standard'. Esa informacion esta en
  `data/gene_positions`. Usad los genes 'no-standard' para filtrar de nuevo
  vuestra lista de Ensembl
  SOLUCION: `mkdir tmp; grep "\(HS\|HG\|LRG\|GL\)" data/gene_positions > tmp/bad_genes; grep -F -w -f data/wnt_genes results/gene_names | grep -v -F -w -f tmp/bad_genes`

* Ejercicio 5: Unid el fichero `data/identifiers` con `data/gene_positions`
  utilizando el comando `join` y colocadlo en `results/gene_info`.
  SOLUCION: `sort data/identifiers > tmp/ids; sort data/gene_positions > tmp/pos; join tmp/ids tmp/pos >  tmp/joined`

Para realizar el ejercicio 5 habra que ordenar primero los archivos utilizando `sort`.

