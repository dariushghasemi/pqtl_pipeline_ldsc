#!/usr/bin/bash

#source /exchange/healthds/singularity_functions
#source ~/bin/miniconda3/etc/profile.d/conda.sh

base=/home/dariush.ghasemi/projects/pqtl_pipeline_ldsc
ldsc=/home/dariush.ghasemi/bin/ldsc

#conda activate ldsc

python  $ldsc/ldsc.py  \
		--h2 data/test_prot1_clean.gz  \
		--ref-ld-chr output/ld.subset_chr22_2  \
		--w-ld-chr output/ld.subset_chr22_2  \
		#--overlap-annot  \
		#--frqfile-chr 1000G.mac5eur.  \
		--out output/ldsc_test_prot1

