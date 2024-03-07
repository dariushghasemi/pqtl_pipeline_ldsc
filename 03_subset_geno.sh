#!/usr/bin/bash

base=/home/dariush.ghasemi/projects/pqtl_pipeline_ldsc
#plink=~/bin/plink_install/plink

# extract rsids of the first 1000 variants in CHR22 for test run
#head -1000 $base/data/chr22.bim | cut -f2 > $base/data/subset_variants.list

# Just to ensure the variants extraction is completed
#sleep 10

# subset genotype file to a smaller group of variants
plink   --bfile $base/data/chr22 \
        --extract $base/data/subset_variants.list \
        --zero-cms \
        --make-bed \
        --out $base/data/subset_chr22
