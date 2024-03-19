######### C.5. Save variants with info_score > 0.7

# import configuration file
configfile: "config_qc.yaml"

# define a function to retrieve gwas summary report
def get_sumstats():
    return str(Path(config.get("sumstat_path"),config.get("sumstat_file")))

# make the path towards output report file
def dest_path(file_path):
    return str(Path(config.get("variant_list"),file_path))

# make the required inputs using the defined path to the report file
rule all:
    input:
        expand(
            dest_path("/home/dariush.ghasemi/projects/pqtl_pipeline_ldsc/hq_variants_chr{chrom}.txt"),
            chrom=[i for i in range(19, 21)]
        )

# define instructions to filter for INFO score
rule filter_hq_variants:
    input:
        sum_stats = get_sumstats() #"/group/diangelantonio/users/alessia_mapelli/QC_gen_INTERVAL/QC_steps/StepB/New_analysis/recomputed_stats/recoded/snp-stats_chr{chrom}.txt"
    output:
        snp_list  = "/home/dariush.ghasemi/projects/pqtl_pipeline_ldsc/hq_variants_chr{chrom}.txt",
        log = "/home/dariush.ghasemi/projects/pqtl_pipeline_ldsc/report_chr{chrom}.log"
    container:
        "docker://quay.io/biocontainers/plink2:2.00a5--h4ac6f70_0"
    #resources:
    #    runtime=lambda wc, attempt: attempt * 60,
    params:
        snp_list  = "/home/dariush.ghasemi/projects/pqtl_pipeline_ldsc/hq_variants_chr{chrom}.txt"
    log:
        "report_chr{chrom}.log"
    shell:
        """
        total_rows=$(grep -v ^#  {input.sum_stats} | wc -l) && \
        echo "Number of rows before filtering for INFO score > 0.7: $total_rows" >> {output.log} && \
        grep -v ^#  {input.sum_stats} | \
        awk '$17 > 0.7 {{ print $2 }}'  >  {output.snp_list} && \
        filtered_rows=$(wc -l < {output.snp_list}) && \
        echo "Number of rows after filtering for INFO score > 0.7: $filtered_rows" >> {output.log}
        """


#str(Path(config.get("sumstat_path")))
#str(Path(config.get("working_path"), "/report_chr{chrom}.txt"))
#sum_stats = config.get("sumstat_path")