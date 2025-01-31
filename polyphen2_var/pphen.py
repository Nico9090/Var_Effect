#!/usr/bin/env python3
import re
import requests
import pandas as pd
class Polyphen_predict():
        def __init__(self,csv_file):
                self.csv_file=csv_file
        def parse_mutant_data(self,row_num):
                df=pd.read_csv(self.csv_file)
                accid=df.iloc[row_num]["Gene"]
                vus=df.iloc[row_num]["VUS"]
                seqpos=vus[vus.index("p"):]
                seqpos= "".join(re.findall(r'\d+', seqpos))
                aa=vus[vus.index("p")+2:]
                aa="".join(re.findall(r'[a-zA-Z]+',aa))
                varSel1=aa[0]
                varSel2=aa[1]
                return accid,varSel1,seqpos,varSel2
        def polyphen_pred(self,parsed_data):
                url="http://genetics.bwh.harvard.edu/pph2/"
                query_data={
                        "submit":"Submit",
                        "accid":parsed_data[0],
                        "varSel1":parsed_data[1],
                        "seqpos":parsed_data[2],
                        "varSel2":parsed_data[3]}
                query_response=requests.post(url,data=query_data)
                if query_response.status_code == 200:
                        print("Successfull submission")
                        return query_response.text
                else:
                        print("Failed submission")
                        return query_response.status_code
vus1=Polyphen_predict("test/VUS_and_genes.csv")
parsed_data=vus1.parse_mutant_data(1)
print(vus1.polyphen_pred(parsed_data))
