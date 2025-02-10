#!/bin/bash

#For orthofinder to find orthogroup

orthofinder -f ./ -t 50 -a 50 -M msa -T iqtree -o  Result.pep.$(date +%Y%m%d%H%M%S) 
#for pep sequence


orthofinder -f ./ -d -t 50 -a 50 -M msa  -o  Result.cds.$(date +%Y%m%d%H%M%S)  
#for cds sequence