# pqtl_pipeline_ldsc
In the repository, we work on the LD Score regression analysis, a part of the pQTL pipeline.

- The ldsc regression sub-analysis was initiated today (Fri, 10:55, 01-Mar-24).

- The genotypes of the INTERVAL study are stored on `/processing_data/shared_datasets/plasma_proteome/interval/genotypes/`.

- The study has 743,989 SNPs for 42,396 individuals. The annotation file is available for 43,732 with batch + 50 PCs `annot_INT_50PCs_pcs.txt` and for 44,814 with only population + 50 PCs `annot_INT_1KG_50_PCs_pcs.txt`.

- Munging summary statistics of protein GWAS was done on 176,654 variants in CHR22. Having been munged, 139,401 variants whose rs number was detected left for the h2 calculation (Mon, 23:36, 11-Mar-24).

- LD score regression was implemented on the testing GWAS summary stats (Tue, 01:00, 12-Mar-24).

- Working on genetic correlation. As CORRELATION MEANS, it works only if we have two phenotypes.

- Adding scripts munging summary stats and computing heritability to the pipeline (Thu, 11:45, 14-Mar-24).

- Computing LD step has been run on clusters (Thu, 04:15, 21-Mar-24).

- As the genotype data was previously merged and plink is the required format of ldsc app, I used `04_compute_ld.sh` to estimate LD for the entire variants in the merged file for the cohort (Thu, 17:00, 21-Mar-24). 

- These steps have been integrated into the chain codes:
    1. conversion of the genotype from pgen/pvar/psam to bed/bim/fam via rule **convert_pgen** in `01_compute_ld.smk`,
    2. estimation of LD using the converted binary genotypes via rule **compute_ld** in `01_compute_ld.smk`
    3. calculating P-value based on -LOG10P via rule **append_pvalue** in `Snakefile`
    4. munging summary statistics of protein GWAS via rule **munge_sumstats** in `Snakefile`
    5. fitting LD score regression to each of the munged  sumstats via rule **compute_herit** in `Snakefile` 

- The workflow is ready to perform test run on the clusters using 6 selected sumstats and LD estimated from the imputed genotype data (Wed, 02:57, 27-Mar-24).


Dariush
