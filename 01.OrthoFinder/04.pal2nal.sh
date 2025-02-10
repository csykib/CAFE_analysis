#!/bin/bash
#For pal2nal

for i in $(cat OG.name)
do
	~/bin/pal2nal.v14/pal2nal.pl data/$i.pep_mafft.fasta data/$i.cds.fasta > Result/$i.pal2nal.fasta -output fasta
done

 pal2nal