#===============================================================================
library(mutscan)
library(rentrez)
library(tidyverse)
#===============================================================================
#Protein: PKHD1

#Functions======================================================================
#Use Rentrez to obtain mRNA sequence
#*******************************************************************************
mRNA_get<-function(species,gene){

  res<- entrez_search(db="nucleotide", 
                      term=paste(species,"[Species]", "AND ", gene,"[Gene]")
  )
  outfile<-paste(gene,"rna.txt")%>%gsub(" ", "",.) #. is placeholder for result
  opened_file<-file(outfile
       ,"w")
  writeLines(entrez_fetch(db="nucleotide", 
                          id=res$ids[1],#first id matches search term 
                          rettype="gb", 
                          retmode="text"),outfile)
  close(opened_file)
  return()

}

