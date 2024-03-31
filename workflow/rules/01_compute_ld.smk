
from pathlib import Path

configfile: "../conf/config_ldsc.yaml"


def ws_path(file_path):
    return str(Path(config.get("path_base"), file_path))

def db_path(file_path):
    return str(Path(config.get("path_data"), file_path))


rule all:
    input: 
        expand(
            ws_path("output/ld/ld.interval_imputed_chr{chrom}"),
            chrom=[i for i in range(1, 21)]
        )


rule convert_pgen:
    input:
        pgen  = db_path("pgen/impute_recoded_selected_sample_filter_hq_var_{chrom}.pgen")
    output:
        bedfile = ws_path("output/plinkFormat/impute_recoded_selected_sample_filter_hq_var_chr{chrom}.bed"),
        bimfile = ws_path("output/plinkFormat/impute_recoded_selected_sample_filter_hq_var_chr{chrom}.bim"),
        famfile = ws_path("output/plinkFormat/impute_recoded_selected_sample_filter_hq_var_chr{chrom}.fam")
    params:
        pgen  = db_path("pgen/impute_recoded_selected_sample_filter_hq_var_{chrom}"),
        plink = ws_path("output/plinkFormat/impute_recoded_selected_sample_filter_hq_var_chr{chrom}")
    log:
        ws_path("logs/conversion/interval_imputed_chr{chrom}.log")
    container:
        "docker://quay.io/biocontainers/plink2:2.00a5--h4ac6f70_0"
    shell:
        """
        source /exchange/healthds/singularity_functions &&  \
        plink2  \
            --pfile  {params.pgen} \
            --make-bed  \
            --out    {params.plink}  \
            --threads 8  \
            --memory 90000 'require' 2> {log}
        """


rule compute_ld:
    input:
        bedfile = ws_path("output/plinkFormat/impute_recoded_selected_sample_filter_hq_var_chr{chrom}.bed"),
        bimfile = ws_path("output/plinkFormat/impute_recoded_selected_sample_filter_hq_var_chr{chrom}.bim"),
        famfile = ws_path("output/plinkFormat/impute_recoded_selected_sample_filter_hq_var_chr{chrom}.fam")
    output:
        ofile = ws_path("output/ld/ld.interval_imputed_chr{chrom}"),
    params:
        ifile = ws_path("output/plinkFormat/impute_recoded_selected_sample_filter_hq_var_chr{chrom}")
    log:
        ws_path("logs/ld/ld.interval_imputed_chr{chrom}.log")
    container:
        "docker://quay.io/biocontainers/plink2:2.00a5--h4ac6f70_0"
    resources:
        runtime=lambda wc, attempt: attempt * 1440,
    #conda:
        #"envs/ldsc.yml"
    shell:
        "source ~/.bashrc && " 
        "conda activate ldsc  && "
        "ldsc.py  "
        "    --bfile {params.ifile} "
        "    --l2  "  
        "    --maf 0.05  "
        "    --ld-wind-cm 1  "
        "    --yes-really  "
        "    --out {output.ofile}  2> {log}"

