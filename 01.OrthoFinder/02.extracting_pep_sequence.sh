#!/bin/bash
#For extracting pep sequence

#species name from cds_extracting

for i in $(ls ./Result/*nameforcds)
do
for j in $(ls *pep)
	do
		seqkit grep -f $i $j -o $i.$j.pep
	done
done
#extrating pep sequence


for i in $(cat OG.name)
do
	for j in $(cat Sp.name)
	do
		for line in $(cat Result/$i.nameforcds.$j.pep.pep)
		do
			line=${line%%' '*}
			echo $line >> Result/$i.$j.pep.pep.tmp 
		done
	done
done
IFS=$' \t\n'
#change name of pepSeq



IFS=$' \t\n' 
for i in $(ls Result/*pep.pep.tmp)
do
	myarray=($(echo $i | sed 's/\./ /g')) 
	for j in $(cat $i)
	do
		jj=$j
		if [ ${jj:0:1} = '>' ]
		then
			jj=${j%%\>*}
			jj='>'${myarray[1]}
			echo $jj  >> $i.peptmp
		else
			echo $jj  >> $i.peptmp
		fi
	done
done
#change seqname based filename

for i in $(cat OG.name)
	do
	for j in $(ls Result/$i*peptmp)
	do
		cat $j >> $i.pep.fasta
	done
done
# cat pepseq
