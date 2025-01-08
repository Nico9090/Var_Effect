#===============================================================================
library(mutscan)
library(rentrez)
#===============================================================================
#Protein: PKHD1

#Functions======================================================================
get_mrNA_seq<-function(gene_name){
  #'Obtain the mrNA sequence of a protein
  #FROM CHATGPT
  search_results <- entrez_search(db="nucleotide", term=gene_name)
  mRNA_id <- search_results$ids[1]
  mRNA_sequence <- entrez_fetch(db="nucleotide", id=mRNA_id, rettype="gb", retmode="text")
  mRNA_seq<-sub(paste0(".*", "ORIGIN", "\\s*"), "", mRNA_sequence)
  return(mRNA_seq)

}
writeLines(paste("Read", line_num), fastq_file)
make_fastq<-function(gene_mRNA,fastq_file_name){
  seq<-strsplit(gene_mRNA,"\n")
  fastq_file<-file(fastq_file_name,"w")
  for(line in seq){
    line_num<-1
    writeLines(paste("Read ",line_num),fastq_file)
    writeLines(line,fastq_file)
    writeLines("+",fastq_file)
    writeLines(paste(rep(40, nchar(length(line)))),fastq_file)
    line_num=line_num+1
  }
  
  close(fastq_file)
  return(fastq_file)
}

pkhd1_mrna<-get_mrNA_seq("PKHD1")
make_fastq(pkhd1_mrna,"pkhd1_mrna.fastq")
print(pkhd1_mrna_fastq)
