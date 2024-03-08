#!/usr/bin/bash

source ~/.bashrc

ldsc=/home/dariush.ghasemi/bin/ldsc

pgwas=/exchange/healthds/pQTL/results/INTERVAL/chunk_4503/chunk_4503_output/chunk_4503/results/gwas
zcat $pgwas/seq.3007.7.gwas.regenie.gz | head -1000 | gzip -cd > data/test_prot1.gz

sleep 10

# rshapre protein GWAS summary stats
python $ldsc/munge_sumstats.py  \
        --sumstats data/test_prot1.gz  \
        --out data/test_prot1_clean  \
        --a1-inc

#--merge-alleles w_hm3.snplist  \

#sbatch 05_reshape_sumstats.sh -p cpu-interactive  --mem-per-cpu=4GB -J comp_ld.sh
