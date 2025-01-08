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

make_fastq<-function(gene_mRNA){
  seq<-strsplit(gene_mRNA,"\n")
  return(seq)
}

pkhd1_mrna<-get_mrNA_seq("PKHD1")
pkhd1_mrna_fastq<- make_fastq(pkhd1_mrna)
print(pkhd1_mrna_fastq)
