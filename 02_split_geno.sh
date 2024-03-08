#!/usr/bin/bash

genotype=/processing_data/shared_datasets/plasma_proteome/interval/genotypes
plink=~/bin/plink_install/plink

$plink  --bfile $genotype/merged_imputation  \
        --chr 22  \
        --make-bed   \
        --out chr22

#cat 02_split_geno.sh | sbatch -p cpu-interactive  --mem-per-cpu=16GB -J extract.sh
