#!/usr/bin/bash

#SBATCH --job-name=04.sh
#SBATCH --output %j_compte_ld.log
#SBATCH --partition cpuq
#SBATCH --cpus-per-task 1
#SBATCH --mem 64G
#SBATCH --time 100:00:00

genotype=/processing_data/shared_datasets/plasma_proteome/interval/genotypes
base=/home/dariush.ghasemi/projects/pqtl_pipeline_ldsc
ldsc=/home/dariush.ghasemi/bin/ldsc

source ~/.bashrc
conda activate ldsc

ldsc.py  \
	--bfile $genotype/merged_imputation  \
	--l2  \
    --maf 0.05  \
	--ld-wind-cm 1  \
	--yes-really  \
	--out $base/output/ld/ld.merged_imputation

#sbatch 04_compute_ld.sh -p cpuq  --mem-per-cpu=16GB -J comp_ld.sh

