
import os
from os.path import join as pjoin

# Set configuration file
configfile: "config_ldsc.yaml"

wildcard_constraints:
  chrom="\d+"

# Output directory
outdir = config["output_dir"]

# Input directory
resdir = config["sumstat"]["resdir"]

if not os.path.exists(outdir):
  os.makedirs(outdir, exist_ok=True)

# Get number of phenotypes to retrieve from directory
def get_phenos(resdir):
  myfiles = os.listdir(resdir)
  myfiles = [f for f in myfiles if f.endswith(".regenie.gz.tbi")]
  phenos = [f.replace(".regenie.gz.tbi", "") for f in myfiles]
  return(phenos)

rule all:
  input:
    pjoin(outdir, 'all_lambdas.csv')

rule compute_ldscore:
  input:
    smstat = 'tmp_ldscore/{pheno}/munged.sumstats.gz',
  output:
    ldsc = 'tmp_ldscore/{pheno}/ldsc.log'
  conda:
    "envs/ldsc.yml"
  resources:
    mem_mb = 12000
  params:
    ofile = lambda wildcards, output: output.ldsc.replace(".log", ""),
    ldref = config['ldscore_reference']
  shell:
    "source ~/.bashrc &&"
    "conda activate ldsc &&"
    "ldsc.py --h2 {input.smstat} "
    "--ref-ld-chr {params.ldref}/chr@ "
    "--w-ld-chr {params.ldref}/chr@ --out {params.ofile}"


