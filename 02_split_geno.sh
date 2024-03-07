#!/usr/bin/bash

plink=~/bin/plink_install/plink

$plink  --bfile /processing_data/shared_datasets/plasma_proteome/interval/genotypes/merged_imputation  \
        --chr 22  \
        --make-bed   \
        --out chr22

#cat 02_split_geno.sh | sbatch -p cpu-interactive  --mem-per-cpu=16GB -J extract.sh
