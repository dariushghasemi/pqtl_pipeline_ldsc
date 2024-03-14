
rule reshape_sumstats:
    input:
        app = "/home/dariush.ghasemi/bin/ldsc/munge_sumstats.py",
        ifile = "data/test_prot1.22.to_clean.gz"
    output:
        ofile = "data/test_prot1.22.cleaned.pip"
    conda:
        "ldsc"
    shell:
        "source ~/.bashrc &&"
        "conda activate ldsc &&"
        "python   {input.app} "
        "--sumstats {input.ifile} "
        "--snp variant_id "
        "--a1 effect_allele "
        "--a2 non_effect_allele "
        "--p pvalue "
        "--frq frequency "
        "--N-col sample_size "
        "--chunksize 500000 "
        "--a1-inc "
        "--out {output.ofile} "
