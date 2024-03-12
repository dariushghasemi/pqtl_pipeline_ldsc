#!/usr/bin/bash

#SBATCH --job-name 06.sh
#SBATCH --partition cpuq
#SBATCH --cpus-per-task 1
#SBATCH --mem 4G
#SBATCH --time 50:00:00

source ~/.bashrc
base=/home/dariush.ghasemi/projects/pqtl_pipeline_ldsc
ldsc=/home/dariush.ghasemi/bin/ldsc

conda activate ldsc

python  $ldsc/ldsc.py  \
		--h2 data/test_prot1.22.cleaned.sumstats.gz  \
		--ref-ld output/ld.subset_chr22_2  \
		--w-ld output/ld.subset_chr22_2  \
		--out output/ldsc_test_prot1

#--overlap-annot  \
#--frqfile-chr 1000G.mac5eur.  \
#--h2 data/test_prot1.cleaned.sumstats.gz  \