
from pathlib import Path

configfile: "conf/config_ldsc.yaml"


def ws_path(file_path):
    return str(Path(config.get("path_base"), file_path))


rule all:
    input: 
        expand(
            ws_path("output/test/ld.subset_chr{chrom}"),
            chrom=[i for i in range(21, 23)]
        )


rule compute_ld:
    input:
        bedfile = ws_path("data/subset_chr{chrom}.bed"),
        bimfile = ws_path("data/subset_chr{chrom}.bim"),
        famfile = ws_path("data/subset_chr{chrom}.fam")
    output:
        ofile = ws_path("output/test/ld.subset_chr{chrom}"),
        log   = ws_path('output/test/ld.subset_chr{chrom}.log')
    params:
        ifile = ws_path("data/subset_chr{chrom}")
    container:
        "docker://quay.io/biocontainers/plink2:2.00a5--h4ac6f70_0"
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
        "    --out {output.ofile}"

