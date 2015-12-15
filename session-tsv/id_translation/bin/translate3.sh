#!/bin/bash

gene_file=$1
format=$2

root=`dirname $0`/..
id_file=$root/data/identifiers
pos_file=$root/data/gene_positions

blacklist=$root/var/blacklist
main_index_file=$root/var/main_index
index_file=$root/var/index.${format/\//_}
tmp_ensembl_file=$root/tmp/ensembl.$RANDOM
tmp_ensembl_file_full=$tmp_ensembl_file.full
tmp_ensembl_file_orig=$tmp_ensembl_file.orig
tmp_result=$root/tmp/result.$RANDOM

if [ ! -e $blacklist ]; then
    cut -f 1,2 $pos_file |grep -Pv 'ENSG\d*\s[xy0-9]{1,2}'|cut -f 1 > $blacklist
fi

if [ ! -e "$index_file" ]; then
    field_pos=`head -n 2 data/identifiers |tail -n 1 |tr '\t' '\n'|nl|grep "$format"|head -n 1|cut -f 1|sed s/[[:space:]]//g `
    grep -v -w -F -f "$blacklist" "$id_file" |cut -f 1,$field_pos > "$index_file"
fi

if [ ! -e "$main_index_file" ]; then
    grep -v -w -F -f "$blacklist" "$id_file" > "$main_index_file"
fi

grep -w -F -f "$gene_file" "$main_index_file" > $tmp_ensembl_file_full
grep -o -w -F -f "$gene_file" "$main_index_file" > $tmp_ensembl_file_orig
cut -f 1 $tmp_ensembl_file_full > $tmp_ensembl_file

grep -w -F -f "$tmp_ensembl_file" "$index_file"|cut -f 2 > $tmp_result
paste $tmp_ensembl_file_orig $tmp_result
rm $tmp_ensembl_file $tmp_ensembl_file_full $tmp_ensembl_file_orig $tmp_result
