#!/bin/bash

XML=$(cat <<EOF
    <?xml version="1.0" encoding="UTF-8"?><!DOCTYPE Query>
    <Query completionStamp="1" virtualSchemaName = "default" formatter = "TSV" header = "0" uniqueRows = "1" count = "" datasetConfigVersion = "0.6" >
        <Dataset name = "DATASET" interface = "default" > 
        ATTRIBUTES
        </Dataset> 
    </Query>
EOF
)
URL="http://www.ensembl.org/biomart/martservice?query="

ATTR='<Attribute name = "ATTR_NAME" />'

dataset=$1
shift

attrs=""
while [ $# -gt 0 ]; do
    arg=$1
    shift
    new_attr=`echo $ATTR|sed "s/ATTR_NAME/$arg/"`
    attrs="$attrs\n$new_attr"
done

final_xml=`echo $XML |sed "s/DATASET/$dataset/; s#ATTRIBUTES#$attrs#"`

url="${URL}${final_xml}"

wget "$url" -O -
