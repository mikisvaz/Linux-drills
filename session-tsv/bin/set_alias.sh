#!/bin/bash

alias numera_tabs='ruby -lne '\''i=0;puts $_.split(/\t/, -1).collect{|e| i +=1;"(#{i}) #{e}"}.join("\t")'\'''

function get_line(){
  local line=$1
  local file=$2

  head -n $line "$file" | tail -n 1
}
