#!/usr/bin/bash

#SBATCH --job-name=04.sh
#SBATCH --partition cpuq
#SBATCH --cpus-per-task 1
#SBATCH --mem 4G
#SBATCH --time 100:00:00
#SBATCH --array=19-21


path_data=/scratch/giulia.pontali/test_snakemake/genomics_QC_pipeline/results

source /exchange/healthds/singularity_functions

for chrom in `seq 17 18`
do
  plink2   \
    --pfile $path_data/pgen/impute_recoded_selected_sample_filter_hq_var_${chrom}  \
    --make-bed  \
    --out output/plinkFormat/impute_recoded_selected_sample_filter_hq_var_chr${chrom} \
    --threads 8  \
    --memory 90000 'require'
done
