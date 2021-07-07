#!/bin/bash

# Assign the filename
filename=$1

# Take the search string
read -p "Valor a ser procurado: " search

# Take the replace string
read -p "Novo valor: " replace

if [[ $search != "" && $replace != "" ]]; then
  sed -i "s/$search/$replace/" $filename
  echo -e '\nVARIÁVEL ALTERADA COM SUCESSO'
fi
