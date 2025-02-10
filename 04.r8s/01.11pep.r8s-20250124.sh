module av
module load python/2



python  ~/bin/CAFE5/tutorial/prep_r8s.py -i SpeciesTreeAlignment.11pep_rooted.tree -o SpeciesTreeAlignment.11pep_rooted.MGML.r8sp -s 323202 -p 'Metru,Lyrho' -c '68.00' -p 'Metru,Glmax' -c '55.00'  

#-p 'Metru,Glmax' -c '55.00'  
#-p 'Glmax,Lyrho' -c '68.00' 

~/bin/r8s1.81/src/r8s -b -f SpeciesTreeAlignment.11pep_rooted.MGML.r8sp > SSpeciesTreeAlignment.11pep_rooted.MGML.r8s.tmp 

tail -n 1 SpeciesTreeAlignment.11pep_rooted.MGML.r8s.tmp  |cut -c 16- > SpeciesTreeAlignment.11pep_rooted.MGML.r8s.tree 

python  ~/bin/CAFE5/tutorial/prep_r8s.py -i SpeciesTreeAlignment.11pep_rooted.tree -o SpeciesTreeAlignment.11pep_rooted.MG.r8sp -s 323202 -p 'Metru,Glmax' -c '55.00'  

#-p 'Metru,Glmax' -c '55.00'  
#-p 'Glmax,Lyrho' -c '68.00' 

~/bin/r8s1.81/src/r8s -b -f SpeciesTreeAlignment.11pep_rooted.MG.r8sp > SpeciesTreeAlignment.11pep_rooted.MG.r8s.tmp 

tail -n 1 SpeciesTreeAlignment.11pep_rooted.MG.r8s.tmp  |cut -c 16- > SpeciesTreeAlignment.11pep_rooted.MG.r8s.tree 
