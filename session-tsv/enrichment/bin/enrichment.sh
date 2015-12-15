#!/bin/bash

gene_file=$1
format=$2

root=`dirname $0`/..
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

[ -d $data_dir ] || mkdir $data_dir
[ -d $var_dir ] || mkdir $var_dir
[ -d $tmp_dir ] || mkdir $tmp_dir

if [ ! -e $blacklist ]; then
    cut -f 1,2 $pos_file |grep -Pv 'ENSG\d*\s[xy0-9]{1,2}'|cut -f 1 > $blacklist
fi

if [ ! -e $clean_go ]; then
    grep -v -F -w -f $blacklist $go_file > $clean_go
fi

if [ ! -e $all_terms ]; then
    cut -f 2 $clean_go | tr '|' '\n' | grep GO |sort -u > $all_terms
fi

if [ ! -e $term_counts ]; then
    for t in `cat $all_terms`; do
        count=`grep $t $clean_go | wc -l`
        echo "$t	$count" >> $term_counts
    done
fi


grep -w -F -f $gene_file $clean_go > $matches

cut -f 2 $matches | tr '|' '\n' |grep GO |sort -u > $matched_terms

num_genes=`wc -l $gene_file|cut -f 1 -d ' '`
num_genes_all=`wc -l $clean_go|cut -f 1 -d ' '`
for t in `cat $matched_terms`; do
    count=`grep $t $matches|wc -l`
    if [ $count -ge 3 ]; then
        all_counts=`grep $t $term_counts|cut -f 2`
        rest=$(( $num_genes_all - $all_counts ))
        pvalue=`echo "phyper($count - 1, $all_counts, $rest, $num_genes, F)" | R --slave|grep "[1]"|sed 's/.* \([0-9\.]\+\).*/\1/'`
        echo "$t	$count	$all_counts	$rest	$num_genes	$pvalue"
    fi
done

