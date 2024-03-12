# pqtl_pipeline_ldsc
In the repository, we work on the LD Score regression analysis, a part of the pQTL pipeline.

- The ldsc regression sub-analysis was initiated today (Fri, 10:55, 01-Mar-24).

- The genotypes of the INTERVAL study are stored on `/processing_data/shared_datasets/plasma_proteome/interval/genotypes/`.

- The study has 743,989 SNPs for 42,396 individuals. The annotation file is available for 43,732 with batch + 50 PCs `annot_INT_50PCs_pcs.txt` and for 44,814 with only population + 50 PCs `annot_INT_1KG_50_PCs_pcs.txt`.

- Munging summary statistics of protein GWAS was done on 176,654 variants in CHR22. Having been munged, 139,401 variants whose rs number was detected left for the h2 calculation (Mon, 23:36, 11-Mar-24).

- LD score regression was implemented on the testing GWAS summary stats (Tue, 01:00, 12-Mar-24).

- Working on genetic correlation. As CORRELATION MEANS, it works only if we have two phenotypes.

Dariush
