#!/usr/bin/env python3
from Bio import Entrez #idea to use modules source: CHATGPT
from Bio import SeqIO
import pandas as pd
import textwrap
df=pd.read_csv("VUS_and_scores.csv")
df["Gene"]=df["Gene"]+"_HUMAN" # format for gene:"LAMB2_HUMAN"
def search_uniprot_ids(query):
        Entrez.email = ""
        handle = Entrez.esearch(db="protein", term=query, retmax=10)  # Search for top 10 results
        record = Entrez.read(handle)
        try:
                result=record["IdList"][0]
        except IndexError:
                return None
        else:
                return result
gene_ids=[]
for i in range(len(df)):
        gene_ids.append(search_uniprot_ids(df.iloc[i]["Gene"]))

def get_protein_sequence(accession):
    Entrez.email = ""
    handle = Entrez.efetch(db="protein", id=accession, rettype="gb", retmode="text")
    record = SeqIO.read(handle, "genbank")
    return record.seq

for i in range(len(gene_ids)):
        fasta_file=open((df.iloc[i]["Gene"]+".fasta"),'w')
        try:
                seq=get_protein_sequence(gene_ids[i])
        except TypeError:
                continue
        else:
                print(textwrap.fill(str(seq),width=50),file=fasta_file)
        fasta_file.close()
