BioMart
=======

Mucha de la informacion que necesitais esta disponible en BioMart. Navegando a
la [pagina]:(http://www.ensembl.org/biomart/) podemos elegir la query que
queremos. Desde ahi podemos ver el resultado y bajarlo como fichero de texto.
Tambien es posible utilizar `wget` para bajar ese fichero. Para ello debemos
construir una query compuesta de una URL y un texto XML con la descripcion de
lo que queremos. Abajo tenemos el formato de la URL y un XML de ejemplo

* URL: http://www.ensembl.org/biomart/martservice?query=XML
* XML: 
    ```
    <?xml version="1.0" encoding="UTF-8"?><!DOCTYPE Query>
    <Query completionStamp="1" virtualSchemaName = "default" formatter = "TSV" header = "0" uniqueRows = "1" count = "" datasetConfigVersion = "0.6" >
        <Dataset name = "hsapiens_gene_ensembl" interface = "default" > 
            <Attribute name = "ensembl_gene_id" />
            <Attribute name = "entrezgene"/> 
            <Attribute name = "ensembl_peptide_id"/> 
        </Dataset> 
    </Query>
    ```

Podeis obtener el XML para vuestra query desde BioMart, o tambien podies
directamente crear el XML. He creado un script in `bin/biomart.sh`, utilizadlo
para bajar los terminos GO asociados a cada gen.
