#!/usr/bin/env python3
import request
import pandas as pd
def get_score(csv_file):
        df=pd.read_csv(csv_file)

requester_url="http://genetics.bwh.harvard.edu/pph2/"
query={"accid":,"seqres":,"seqpos":,"varSel1":,"varSel2":,"submit":}
response = requests.post(requester_url, data=query)
