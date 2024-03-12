#!/usr/bin/bash

#SBATCH --job-name 05.sh
#SBATCH --partition cpuq
#SBATCH --cpus-per-task 1
#SBATCH --mem 4G
#SBATCH --time 50:00:00

source ~/.bashrc
ldsc=/home/dariush.ghasemi/bin/ldsc
pgwas=/exchange/healthds/pQTL/results/INTERVAL/chunk_4503/chunk_4503_output/chunk_4503/results/gwas
#zcat $pgwas/seq.3007.7.gwas.regenie.gz | head -1000 | gzip -c > data/test_prot1.gz

#sleep 10
# zcat $pgwas/seq.3007.7.gwas.regenie.gz |  \
#     awk '{ if ($1 == 22) {print }}'  \
#     awk 'BEGIN{print "SNP CHR BP A1 A2 A1FRQ INFO N BETA SE Z LOG10P P"} \
#     NR>1 \
#     {print $3, $1, $2, $4, $5, $6, $7, $8, $10, $11, $12, $13, 10^-$13}'  | \
#     gzip -c > data/test_prot1.22.to_clean.gz


conda activate ldsc

# rshapre protein GWAS summary stats
python $ldsc/munge_sumstats.py  \
        --sumstats data/test_prot1.22.to_clean.gz  \
        --chunksize 500000  \
        --a1-inc  \
        --out data/test_prot1.22.cleaned


#--merge-alleles w_hm3.snplist  \
#--sumstats $pgwas/seq.3007.7.gwas.regenie.gz  \

#sbatch 05_reshape_sumstats.sh -p cpuq  --mem-per-cpu=4GB -J comp_ld.sh
