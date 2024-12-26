#!/bin/bash
exec 3< pkhd1_variants.vcf
while IFS= read -r line <&3; do
        if [[ "$line" =~ ^# ]]; then
                continue
        fi

        chromosome="chromosome "$(echo "$line" | awk '{print $1}')

        echo "Storing $chromosome sequence..."
        chr1=$(grep -n -m 1 "$chromosome " GCF_000001405.40_GRCh38.p14_genomic.fna|cut -d: -f1)
        echo "chr1: "$chr1
        nxt_chrom="chromosome "$(echo "$chromosome" | cut -d' ' -f2|awk '{print$1+1}')
        echo "nxt_chrom: "$nxt_chrom
        chr2=$(grep -n -m 1 "$nxt_chrom " GCF_000001405.40_GRCh38.p14_genomic.fna|cut -d: -f1)
        echo "chr2: "$chr2
        num=$((chr2-chr1))
        echo "num: "$num
        sequence=$(grep -A $num "$chromosome " GCF_000001405.40_GRCh38.p14_genomic.fna)
        new_chrom="${chromosome// /}"
        echo $sequence > "$new_chrom.txt"
done

exec 3<&-

