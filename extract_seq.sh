#!/bin/bash
exec 3< pkhd1_variants.vcf #VCF file, should be a command line component
while IFS= read -r line <&3; do
        if [[ "$line" =~ ^# ]]; then
                continue
        fi
        #Retrieving the portion of the genome that corresponds with the mutation. Identify using chromosome
        chromosome="chromosome "$(echo "$line" | awk '{print $1}')
        position=$(echo "$line" | awk '{print $2}')
        reference=$(echo "$line"|awk '{print $3}')
        alternate=$(echo "$line"|awk '{print $4}')
        #
        echo "Storing $chromosome sequence..."
        chr1=$(grep -n -m 1 "$chromosome " GCF_000001405.40_GRCh38.p14_genomic.fna|cut -d: -f1)
        nxt_chrom="chromosome "$(echo "$chromosome" | cut -d' ' -f2|awk '{print$1+1}')
        chr2=$(grep -n -m 1 "$nxt_chrom " GCF_000001405.40_GRCh38.p14_genomic.fna|cut -d: -f1)
        num=$((chr2-chr1))
        sequence=$(grep -A $num "$chromosome " GCF_000001405.40_GRCh38.p14_genomic.fna)
        new_chrom="${chromosome// /}"
        echo $sequence > "$new_chrom.txt" #should generate new files per chromosome which can then be read
        echo $chromosome $position $reference $alternate
done

exec 3<&-
