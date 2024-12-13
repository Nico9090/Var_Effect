#!/usr/bin/env python3
vcf_components={"CHROM":[1,2,3],"POS":[401,402,403],
                "REF":["A","T","C"],"ALT":["G","A","T"]}
def gen_vcf(outfile,variant_info): 
    '''Generate VCF file with your variant information'''
    with open(outfile,'w')as vcf_file:
        vcf_file.write("##\n"*10)
        vcf_file.write("#")
        for key, value in variant_info.items():
            vcf_file.write(f"{key}\t")
        chrom,pos,ref,alt=variant_info["CHROM"],variant_info["POS"],variant_info["REF"],variant_info["ALT"]
        for x in range(len(chrom)):
            vcf_file.write(f"\n{chrom[x]:>6}\t{pos[x]:>3}\t{ref[x]:>3}\t{alt[x]:>3}\t")
        
gen_vcf("pkhd1_variants.vcf",vcf_components)
