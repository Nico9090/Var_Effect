import argparse
from Bio import Entrez #idea to use modules source: CHATGPT
from Bio import SeqIO
import pandas as pd
import textwrap
#=================================================================================================
#=================================================================================================
#Purpose of this program is to quickly generate fasta files using genes mentioned by name in a csv file

if __name__=="__main__":
        parser=argparse.ArgumentParser(formatter_class= argparse.ArgumentDefaultsHelpFormatter)
        parser.add_argument("--csv_file",type=str,required=True,help="csv file with genes")
        args=parser.parse_args()
        df=pd.read_csv(args.csv_file)
        df["Gene"]=df["Gene"]+"_HUMAN"  # format for gene:"LAMB2_HUMAN"
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
        i=1
        while i<len(df):
                gene_ids.append(search_uniprot_ids(df.iloc[i]["Gene"]))
                i+=1
        #for i in range(len(df)):
        #       gene_ids.append(search_uniprot_ids(df.iloc[i]["Gene"]))
        def get_protein_sequence(accession):
                Entrez.email = ""
                          handle = Entrez.efetch(db="protein", id=accession, rettype="fasta", retmode="text")
                record = SeqIO.read(handle, "fasta")
                return record.description, record.seq
        for i in range(len(gene_ids)):
                fasta_file=open((df.iloc[i]["Gene"]+".fasta"),'w')
                try:
                        header=get_protein_sequence(gene_ids[i])[0]
                        seq=get_protein_sequence(gene_ids[i])[1]
                except ValueError:
                        continue
                except TypeError:
                        continue
                else:
                        print(">",str(header),file=fasta_file)
                        print(textwrap.fill(str(seq),width=50),file=fasta_file)
                fasta_file.close()

