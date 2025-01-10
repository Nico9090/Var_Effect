#!/bin/bash
#SBATCH -J "Scoring Variants"
#SBATCH -o Status.out
#SBATCH -e Error.err
#===============================================================================================================================
##HPC use
module load pandas
module load biopython
module load torch

export PATH=/path/to/esm_score_missense_mutations.py:$PATH #download esm1b from README references
INDIR=/path/to/esm-variants/
OUTDIR=/path/to/results_dir
cd $INDIR

#Run program
for fasta_file in /path/to/fasta_files/*.fasta; do
  file=$(basename "$fasta_file")
  filename="${file%.*}"
  python3 /path/to/esm_score_missense_mutations.py \
    --input-fasta-file=$fasta_file \
    --output-csv-file=$OUTDIR/"$filename.csv"
done
echo 'Variant Scoring Complete!'
