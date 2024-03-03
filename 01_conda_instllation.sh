
# install conda env
#!/usr/bin/sh

df -h $HOME
cd $HOME;
wget -qO- https://micromamba.snakepit.net/api/micromamba/linux-64/latest | tar -xvj bin/micromamba
./apps/bin/bin/micromamba shell init -s bash -p $HOME/micromomba

$ export PATH=$HOME/miniconda3/bin:$PATH;

# or
#wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda.sh;
#bash miniconda.sh -b -p $HOME/miniconda3;
#export PATH=$HOME/miniconda3/bin:$PATH;

bash bin/miniconda.sh -b -p $HOME/apps/bin/miniconda3
export=$HOME/apps/bin/miniconda3/bin:$PATH
export=$HOME/miniconda3/bin/conda:$PATH;
miniconda3/bin/conda init bash
miniconda3/bin/conda config --set auto_activate_base false
exit
srun --nodes=1 --cpus-per-task=2 --mem=4GB --partition=cpu-interactive --pty /bin/bash
conda install -n base conda-libmamba-solver
conda config --set colver libmamba

## install snakemake
mkdir snakemake-tutorial
cd snakemake-tutorial
curl -L https://api.github.com/repos/snakemake/snakemake-tutorial-data/tarball -o snakemake-tutorial-data.tar.gz
tar --wildcards -xf snakemake-tutorial-data.tar.gz --strip 1 "*/data" "*/environment.yaml"
conda activate
conda install -n base -c conda-forge mamba
mamba env create --name snakemake-tutorial --file environment.yaml
conda remove --prefix snakemake-tutorial --all;
conda env create --name snakemake-tutorial --file snakemake-tutorial/environment.yaml
conda activate snakemake-tutorial
conda deactivate
conda env list
## done!

git clone https://github.com/dariushghasemi/pqtl_pipeline_ldsc.git

## add email to account for contributions
git config user.mail "dariush.ghasemi@fht.org"
git config --global user.email "dariush.ghasemi@fht.org"

git config --global --edit
git commit --amend --reset-author


## install ldsc from github
git clone https://github.com/bulik/ldsc.git
cd ldsc

## make ldsc env
conda env create --name ldsc --file environment.yml
source activate ldsc

## test ldsc
./ldsc.py -h
./munge_sumstats.py -h
