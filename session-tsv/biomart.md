BioMart
=======

* URL: http://www.ensembl.org/biomart/martservice?query=XML

* XML: 
    ```
    <?xml version="1.0" encoding="UTF-8"?><!DOCTYPE Query>
    <Query completionStamp="1" virtualSchemaName = "default" formatter = "TSV" header = "0" uniqueRows = "1" count = "" datasetConfigVersion = "0.6" >
        <Dataset name = "scerevisiae_gene_ensembl" interface = "default" > 
            <Attribute name = "ensembl_gene_id" />
            <Attribute name = "entrezgene"/> 
            <Attribute name = "ensembl_peptide_id"/> 
        </Dataset> 
    </Query>
    ```