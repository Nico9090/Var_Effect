#!/bin/bash
genome_file=*genomic.fna #change to actual file name
exec 3< pkhd1_variants.vcf
while IFS= read -r line <&3; do
    if [[ "$line" =~ ^# ]]; then
        continue
    fi
    chromosome="chromosome "$(echo "$line" | awk '{print $1}') #store the chromosome number
    echo "Storing $chromosome sequence..."
    sequence=$(grep -A 1 "$chromosome " $genome_file) #match the chromosome number to the genome file
done

exec 3<&-
