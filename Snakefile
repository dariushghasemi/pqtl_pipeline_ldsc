
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
        "--snp SNP "
        "--a1 A1 "
        "--a2 A2 "
        "--p P "
        "--frq A1FRQ "
        "--N-col N "
        "--chunksize 500000 "
        "--a1-inc "
        "--out {output.ofile} "


rule reshape_sumstats:
    input:
        app = "/home/dariush.ghasemi/bin/ldsc/ldsc.py",
        ifile = "data/test_prot1.22.cleaned.pip.sumstats.gz"
        ldfile = "output/ld.subset_chr22_2"
    output:
        ofile = "output/ldsc_test_prot1.pip"
    conda:
        "ldsc"
    shell:
        "source ~/.bashrc &&"
        "conda activate ldsc &&"
        "python {input.app} "
		"--h2 {input.ifile} "
		"--ref-ld {input.ifile} "
		"--w-ld {input.ifile} "
		"--out {output.ofile} "