#!/usr/bin/env python3
import request
import pandas as pd
def get_score(csv_file):
        df=pd.read_csv(csv_file)

requester_url="http://genetics.bwh.harvard.edu/pph2/"
query={"accid":,"seqres":,"seqpos":,"varSel1":,"varSel2":,"submit":}
response = requests.post(requester_url, data=query)
#===========================================================================================================================

#!/usr/bin/env python3
import re
import pandas as pd

df=pd.read_csv()
for i in range(len(df)):
        accid=df.iloc[i]["Gene"]

#===========================================================================
#Find the sequence position
vus="c.2984 G>A;p.R995H"
seqpos=vus[vus.index("p"):]
seqpos= "".join(re.findall(r'\d+', seqpos))
#===========================================================================
#amino acids
aa=vus[vus.index("p")+2:]
aa="".join(re.findall(r'[a-zA-Z]+',aa))
varSel1=aa[0]
varSel2=aa[1]
#==========================================================================
#gene name
accid=""
#=========================================================================

