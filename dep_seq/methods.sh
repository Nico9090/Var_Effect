#!/bin/bash
#  ||METHODS ||
#  ||        ||
#    ========
#---------------------------------------------------------------------------------------------------------------------------    
#Source: NCBI/SRA
#---------------------------------------------------------------------------------------------------------------------------
#Experiment: 	NCBI/GSE221136, c-MYC overexpression, Setd2 deletion
#---------------------------------------------------------------------------------------------------------------------------

#Workflow


#---------------------------------------------------------------------------------------------------------------------------

# 1. SRA toolkit to obtain .sra 

#*=SRR number
prefetch --output-directory $OUTDIR SRR*
   
#2. SRA -> fastq 
fasterq-dump --outdir $OUTDIR --split-3 SRR*
gunzip *.fastq

#3.
