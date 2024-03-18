

rule all:
    input:
        expand(
            "/group/diangelantonio/users/alessia_mapelli/QC_gen_INTERVAL/QC_steps/StepB/New_analysis/recomputed_stats/recoded/snp-stats_chr{chrom}.txt",
            chrom=[i for i in range(21, 21)]
        )

/group/diangelantonio/users/alessia_mapelli/QC_gen_INTERVAL/QC_steps/StepB/New_analysis/recomputed_stats/recoded/snp-stats_chr9.txt

grep -v ^#  | awk '$17 > 0.7 { print $2, $17}' | head -10

rule filter_hq_variants:
    input:
        get_pgen(),
    output:
        ws_path("pgen/impute_dedup_recoded_{chrom}.pgen"),
    container:
        "docker://quay.io/biocontainers/plink2:2.00a5--h4ac6f70_0"
    resources:
        runtime=lambda wc, attempt: attempt * 60,
    params:
        prefix = ws_path("pgen/impute_dedup_recoded_{chrom}"),
        fasta=config.get("fasta_path"),
        pfile=get_pgen(stem=True),
    shell:
        """