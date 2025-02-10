#!/bin/bash

#For running CAFE

awk -v OFS="\t" '{$NF=null;print $1,$0}' Orthogroups.GeneCount.tsv |sed -E -e 's/Orthogroup/desc/' -e 's/_[^\t]+//g' > Result.20230822110742_gene_families.txt
#changing formation

cafe5 -i Result.20230822110742_gene_families.txt -t SpeciesTree_rooted.r8s.tree -p -c 10 -k 2 -o k2p
cafe5 -i Result.20230822110742_gene_families.txt -t SpeciesTree_rooted.r8s.tree -p -c 10 -k 3 -o k3p
cafe5 -i Result.20230822110742_gene_families.txt -t SpeciesTree_rooted.r8s.tree -p -c 10 -k 4 -o k4p
cafe5 -i Result.20230822110742_gene_families.txt -t SpeciesTree_rooted.r8s.tree -p -c 10 -k 5 -o k5p
cafe5 -i Result.20230822110742_gene_families.txt -t SpeciesTree_rooted.r8s.tree -p -c 10 -k 6 -o k6p
cafe5 -i Result.20230822110742_gene_families.txt -t SpeciesTree_rooted.r8s.tree -p -c 10 -k 7 -o k7p
cafe5 -i Result.20230822110742_gene_families.txt -t SpeciesTree_rooted.r8s.tree -p -c 10 -k 8 -o k8p
cafe5 -i Result.20230822110742_gene_families.txt -t SpeciesTree_rooted.r8s.tree -p -c 10 -k 9 -o k9p
#running CAFE

head -n 1 k*p*/Gamma_resul*
#checing out 'Model Gamma Final Likelihood (-lnL)'

#k=7,Model Gamma Final Likelihood (-lnL): 278179
#k=7 for next analysis

cat Gamma_change.tab |cut -f1,5|grep -v "-" | grep -vw "0$" > Zeins.expanded
# getting expanded family

cat Gamma_change.tab |cut -f1,5|grep "-" > Zeins.contracted
# getting contracted family

grep "Zeins<4>\*" Gamma_asr.tre > Zeins_significant_trees.tre
# getting sinificant expanded or contracted family tree,p=0.05

grep -E -o "OG[0-9]+" Zeins_significant_trees.tre > Zeins_significant.ogs
# getting significant changes orthogroupsID,p=0.05

awk '$2 <0.01 {print $1}' Gamma_family_results.txt > p0.01_significant.ogs
awk '$2 <0.05 {print $1}' Gamma_family_results.txt > p0.05_significant.ogs
# getting  significant changes orthogroupsID, p=0.01 or p=0.05

grep -f Zeins_significant.ogs p0.01_significant.ogs > Zeins_p0.01_significant.ogs
grep -f Zeins_significant.ogs p0.05_significant.ogs > Zeins_p0.05_significant.ogs
# getting  significant changes orthogroupsID, p=0.01 or p=0.05

grep -f Zeins_p0.01_significant.ogs Zeins.expanded |cut -f1 > Zeins.expanded.significant_p0.01
grep -f Zeins_p0.05_significant.ogs Zeins.expanded |cut -f1 > Zeins.expanded.significant_p0.05
# getting  significant expansion orthogroupsID, p=0.01 or p=0.05

grep -f Zeins_p0.01_significant.ogs Zeins.contracted |cut -f1 > Zeins.contracted.significant_p0.01 
grep -f Zeins_p0.05_significant.ogs Zeins.contracted |cut -f1 > Zeins.contracted.significant_p0.05
# getting  significant contraction orthogroupsID, p=0.01 or p=0.05

grep -f Zeins.expanded.significant_p0.01 Orthogroups.txt |sed "s/ /\n/g"|grep "ZEINS" |sort -k 1.3n |uniq > Zeins.expanded.significant_p0.01.genesID
grep -f Zeins.contracted.significant_p0.01 Orthogroups.txt | sed "s/ /\n/g"|grep "Zeins" |sort -k 1.3n |uniq > Zeins.contracted.significant_p0.01.genesID
# getting  significant change geneID, p=0.01

seqkit grep -f Zeins.expanded.significant_p0.01.genesID Zenia_insignis.pep  > Zeins.expanded.significant_p0.01.pep.fa 
seqkit grep -f Zeins.contracted.significant_p0.01.genesID Zenia_insignis.pep > Zeins.contracted.significant_p0.01.pep.fa
# getting  significant change sequence, p=0.01