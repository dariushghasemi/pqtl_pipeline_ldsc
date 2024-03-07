#!/usr/bin/bash

source /exchange/healthds/singularity_functions
source ~/bin/miniconda3/etc/profile.d/conda.sh

base=/home/dariush.ghasemi/projects/pqtl_pipeline_ldsc
ldsc=/home/dariush.ghasemi/bin/ldsc/ldsc.py

#conda init
#conda activate
conda activate ldsc

python $ldsc  \
	--bfile $base/data/subset_chr22  \
	--l2  \
    --maf 0.05  \
	--ld-wind-cm 1  \
	--yes-really  \
	--out $base/output/ld.subset_chr22

#sbatch 04_compute_ld.sh -p cpu-interactive  --mem-per-cpu=16GB -J comp_ld.sh
