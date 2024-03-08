#!/usr/bin/bash

#SBATCH --job-name=04.sh
#SBATCH --mail-type=ALL
#SBATCH --mail-user=dariush.ghasemi@fht.org
#SBATCH --output %j_04compute_ld.sh.log
#SBATCH --partition cpuq
#SBATCH --cpus-per-task 1
#SBATCH --mem 8G
#SBATCH --time 8:00:00

source ~/.bashrc
#source /exchange/healthds/singularity_functions
#source ~/bin/miniconda3/etc/profile.d/conda.sh

base=/home/dariush.ghasemi/projects/pqtl_pipeline_ldsc
ldsc=/home/dariush.ghasemi/bin/ldsc

conda activate ldsc

python $ldsc/ldsc.py  \
	--bfile $base/data/subset_chr22  \
	--l2  \
    --maf 0.05  \
	--ld-wind-cm 1  \
	--yes-really  \
	--out $base/output/ld.subset_chr22

#sbatch 04_compute_ld.sh -p cpu-interactive  --mem-per-cpu=16GB -J comp_ld.sh