# pqtl_pipeline_ldsc
In the repository, we work on the LD Score regression analysis, a part of the pQTL pipeline.

- The ldsc regression sub-analysis was initiated today (Fri, 10:55, 01-Mar-24).

- The genotypes of the INTERVAL study are stored on `/processing_data/shared_datasets/plasma_proteome/interval/genotypes/`.

- The study has 743,989 SNPs for 42,396 individuals. The annotation file is  available for 43,732 with batch + 50 PCs `annot_INT_50PCs_pcs.txt` and for 44,814 with only population + 50 PCs `annot_INT_1KG_50_PCs_pcs.txt`.

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

- The LD test run on CHR21 and CHR22 was completed using `01_compute_ld.smk` on Sat, 23:30, 30-Mar-24.

- After checking the LD scores for CHR21&22, I realized the number of variants were almost less than a half for each chromosome. So, I double checked if this is due to MAF>0.05 filter. SO I followed these two steps:

```{bash}
# filter out SNPs with MAF<0.05 while converting to plink binary
plink --bfile  output/plinkFormat/impute_recoded_selected_sample_filter_hq_var_chr22 --maf 0.05 --make-bed --out output/plinkFormat/impute_recoded_selected_sample_filter_hq_var_chr22.maf05

# check number of variants of the output
wc -l output/plinkFormat/impute_recoded_selected_sample_filter_hq_var_chr22.maf05.bim

```

- As a result, both filtered genotype data (n=79,283) and ld scores (n=79,281) for CHR22 had almost the same #rows. 

- LD score is being computed for teh rest of the loci on the clusters using the pipeline (Sun, 01:07, 31-Mar-24).

- Process of ld calculation *is still on the servers (Fri, 23:50, 05-Apr-24). 


Dariush
