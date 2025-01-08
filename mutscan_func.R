#===============================================================================
library(mutscan)
library(rentrez)
#===============================================================================
#Protein: PKHD1

#Functions======================================================================
#Use Rentrez to obtain mRNA sequence
#*******************************************************************************
mRNA_get<-function(gene){

  #Source code for using Rentrez: CHATGPT
  res<- entrez_search(db="nucleotide", 
                      term="Homo sapiens[Species] AND PKHD1[Gene]")
  
  file("RNA_seq.txt","w")
  writeLines(entrez_fetch(db="nucleotide", 
                          id=res$ids[1],#first id matches search term 
                          rettype="gb", 
                          retmode="text"),"RNA_seq.txt")
  #mRNA_seq<-sub(paste0(".*", "ORIGIN", "\\s*"), 
  #              "", 
  #              mRNA_sequence)
  return()

}
#*******************************************************************************
make_fastq<-function(gene_mRNA,fastq_file_name){
  seq<-unlist(strsplit(gene_mRNA,"\n"))
  
  
  fastq_file<-file(fastq_file_name,"w")
  
  
  line_num<-1
  
  
  for(line in seq){
    
    writeLines(paste("@Read ",line_num),fastq_file)
    
    writeLines(line,fastq_file)
    
    writeLines("+",fastq_file)
    
    quality<-paste(rep("40", nchar(line)), collapse = "")
    
    writeLines(quality, fastq_file)
    
    line_num<-line_num+1
  }
  
  close(fastq_file)
  return(fastq_file)
}

pkhd1_mrna<-get_mrNA_seq("PKHD1")
make_fastq(pkhd1_mrna,"pkhd1_mrna.fastq")
print(pkhd1_mrna_fastq)

