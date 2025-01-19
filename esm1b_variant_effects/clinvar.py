#!/usr/bin/env python3
import requests
main_link="https://api.ncbi.nlm.nih.gov/variation/v0/variant/"
gene_VUS_type='"PKD1"+Missense'
gene_link=f"https://www.ncbi.nlm.nih.gov/clinvar/?term={gene_VUS_type}"

#==============================================================================

web_response=requests.get(gene_link)
print(web_response.text)
#if web_response.status_code == 200:
#    data = web_response.json()
#    print(data) 
#else:
#    print(f"Error: {web_response.status_code}")
