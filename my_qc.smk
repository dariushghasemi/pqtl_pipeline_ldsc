######### C.5. Save variants with info_score > 0.7
import os
from os.path import join as pjoin


# import configuration file
configfile: "config_qc.yaml"

# Input directory
resdir = config["sumstat_path"]

# Output directory
outdir = config["report_path"]


# make the required inputs using the defined path to the report file
rule all:
    input:
        expand(
            pjoin(outdir, "hq_variants_chr{chrom}.txt"),
            chrom=[i for i in range(18, 20)]
        )

# define instructions to filter for INFO score
rule filter_hq_variants:
    input:
        #sum_stats = get_sumstats()
        sum_stats = pjoin(resdir, "snp-stats_chr{chrom}.txt")
    output:
        snp_list = pjoin(outdir, "hq_variants_chr{chrom}.txt"),
        log_file = pjoin(outdir, "report_chr{chrom}.log")
    container:
        "docker://quay.io/biocontainers/plink2:2.00a5--h4ac6f70_0"
    #resources:
    #    runtime=lambda wc, attempt: attempt * 60,
    params:
        snp_list = pjoin(outdir, "hq_variants_chr{chrom}.txt"),
    log:
        "report_chr{chrom}.log"
    shell:
        """
        total_rows=$(grep -v ^#  {input.sum_stats} | wc -l) && \
        echo "Number of rows before filtering for INFO score > 0.7: $total_rows" >> {output.log_file} && \
        grep -v ^#  {input.sum_stats} | \
        awk '$17 > 0.7 {{ print $2 }}'  >  {output.snp_list} && \
        filtered_rows=$(wc -l < {output.snp_list}) && \
        echo "Number of rows after filtering for INFO score > 0.7: $filtered_rows" >> {output.log_file}
        """
