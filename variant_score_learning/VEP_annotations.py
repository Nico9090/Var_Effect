import requests
import json
import subprocess

def annotate(vcf_file):
    '''Does the variant location land within an exon???'''
    variants=subprocess.run("extract_seq.sh")
    variants=variants.stdout
    variants=variants[1:]
    variants=variants.splitlines()

    #need json format for the API
    data ={"variants":[variants[0],variants[1],variants[2]]

    }
    link="https://rest.ensemble.org/vep/human"
    response = requests.post(link,data=json.dumps(data))
    if response.status_code == 200: #from CHATGPT
        vep_results = response.json()
        print(vep_results)
    else:
        print(f"Error: {response.status_code}")
print(annotate())
