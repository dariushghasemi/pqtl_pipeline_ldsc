



rule convert_pgen:
    input:
        pgen  = db_path("pgen/impute_recoded_selected_sample_filter_hq_var_{chrom}.pgen")
    output:
        plink = ws_path("output/plinkFormat/impute_recoded_selected_sample_filter_hq_var_chr{chrom}")
    params:
        pgen  = db_path("pgen/impute_recoded_selected_sample_filter_hq_var_{chrom}.pgen")
    log:
        ws_path("log/converted.interval_imputed_chr{chrom}.log")
    shell:
        """
        source /exchange/healthds/singularity_functions &&  \
        plink2  \
            --pfile  {input.pgen} \
            --recode  \
            --out    {output.plink} 2> {log}
        """
