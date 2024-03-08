
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

# download plink from here
https://www.cog-genomics.org/plink/

# install plink 1.9
cd bin/
wget https://s3.amazonaws.com/plink1-assets/plink_linux_x86_64_20231211.zip
unzip plink_linux_x86_64_20231211.zip -d plink_install
cd plink_install/
cp plink /usr/local/bin
chmod 755 /usr/local/bin/plink
nano ~/.bashrc
export PATH=/usr/local/bin:$PATH


# split chromosome
 plink --bfile filename --extract snpfilename.txt --make-bed --out new_filename
 plink --bfile /processing_data/shared_datasets/plasma_proteome/interval/genotypes/merged_imputation --chr 22 --make-bed --out chr22

#update ldsc env
cd ~/bin/ldsc/
conda env update --file environment.yml

# download regression weights 
wget https://storage.googleapis.com/broad-alkesgroup-public/LDSCORE/1000G_Phase3_weights_hm3_no_MHC.tgz
tar zxvf 1000G_Phase3_weights_hm3_no_MHC.tgz
mv 1000G_Phase3_weights_hm3_no_MHC weights_hm3_no_MHC

########################
Call: 
./ldsc.py \
--out output/ld.subset_chr22 \
--bfile data/subset_chr22 \
--l2  \
--ld-wind-kb 1.0 

Beginning analysis at Thu Mar  7 21:51:09 2024
Read list of 1000 SNPs from data/subset_chr22.bim
Read list of 43059 individuals from data/subset_chr22.fam
Reading genotypes from data/subset_chr22.bed
After filtering, 1000 SNPs remain
Estimating LD Score.
Writing LD Scores for 1000 SNPs to output/ld.subset_chr22.l2.ldscore.gz

Summary of LD Scores in output/ld.subset_chr22.l2.ldscore.gz
             MAF       L2
mean  1.3217e-01   2.6546
std   1.4383e-01   1.6319
min   1.1614e-05   0.9983
25%   1.6943e-02   1.4000
50%   6.7728e-02   2.2244
75%   2.1964e-01   3.3143
max   4.9895e-01  10.0688

MAF/LD Score Correlation Matrix
        MAF      L2
MAF  1.0000  0.5132
L2   0.5132  1.0000
Analysis finished at Thu Mar  7 21:51:15 2024

#---------
Call: 
./ldsc.py \
--ld-wind-cm 1.0 \
--out output/ld.subset_chr22_2 \
--bfile data/subset_chr22 \
--yes-really  \
--l2  

Beginning analysis at Thu Mar  7 22:26:35 2024
Read list of 1000 SNPs from data/subset_chr22.bim
Read list of 43059 individuals from data/subset_chr22.fam
Reading genotypes from data/subset_chr22.bed
After filtering, 1000 SNPs remain
Estimating LD Score.
Writing LD Scores for 1000 SNPs to output/ld.subset_chr22_2.l2.ldscore.gz

Summary of LD Scores in output/ld.subset_chr22_2.l2.ldscore.gz
             MAF       L2
mean  1.3217e-01   2.9386
std   1.4383e-01   1.7568
min   1.1614e-05   0.9911
25%   1.6943e-02   1.5446
50%   6.7728e-02   2.5654
75%   2.1964e-01   3.7303
max   4.9895e-01  10.1957

MAF/LD Score Correlation Matrix
        MAF      L2
MAF  1.0000  0.5361
L2   0.5361  1.0000
Analysis finished at Thu Mar  7 22:26:43 2024

#---------
