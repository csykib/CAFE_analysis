#!/bin/bash

#For raxml to find best tree
#IQtree2 model JTT+F+R4

raxml-ng --all --msa  SpeciesTreeAlignment.Result.pep.fa --model JTT+F+R4 --threads 50 --prefix  SpeciesTreeAlignment.11pep --bs-trees 200 