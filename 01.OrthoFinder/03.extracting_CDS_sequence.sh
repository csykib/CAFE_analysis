#!/bin/bash
#For extracting CDS sequence

for i in  $(ls *fa); do grep \> $i > ./Result/$i.tmp;done

for i in  $(ls *fa) 
do 
	name=${i%.*}
	echo $name >> OG.name 
done

for i in  $(ls *fa) 
do
	name=${i%.*}
	for j in $(cat Result/$name.fa.tmp)
	do 
		ii=${j:1} 
		echo $ii >> Result/$name.nameforcds 
	done
done

for i in  $(ls *cds) 
do 
	name=${i%.*}
	 echo $name >> Sp.name 
 done
 
for i in $(ls ./Result/*nameforcds) 
do
	for j in $(ls *cds)
	do
		seqkit grep -f $i $j -o $i.$j.seq  
	done
done

IFS=$'\n' 
for i in $(cat OG.name)
do
	for j in $(cat Sp.name)
	do
		for line in $(cat Result/$i.nameforcds.$j.cds.seq)
		do
			line=${line%%' '*}
			echo $line >> Result/$i.$j.cds.seq.tmp 
		done
	done
done
IFS=$' \t\n'

IFS=$' \t\n' 
for i in $(ls Result/*cds.seq.tmp)
do
	myarray=($(echo $i | sed 's/\./ /g')) 
	for j in $(cat $i)
	do
		jj=$j
		if [ ${jj:0:1} = '>' ]
		then
			jj=${j%%\>*}
			jj='>'${myarray[1]}
			echo $jj  >> $i.tmp.seq
		else
			echo $jj  >> $i.tmp.seq
		fi
	done
done

for i in $(cat OG.name)
	do
	ii=${i%.*}
	for j in $(ls Result/$ii*cds.seq.tmp.tmp.seq)
	do
		cat $j >> $ii.cds.fasta
	done
done	