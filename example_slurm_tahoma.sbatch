#!/bin/bash
#SBATCH -t 0:59:00
#SBATCH -N 1
#SBATCH -A emsla60288
#SBATCH -p analysis 
#SBATCH -o openfold.output.%j
#SBATCH -e openfold.output.%j
#SBATCH -J of1
source /etc/profile.d/modules.sh
module purge
module load gcc
export https_proxy=http://proxy.emsl.pnl.gov:3128
#module load python
org_dir=`pwd`
cd /big_scratch
mkdir -p fasta_dir
cp $org_dir/benchmark_24aas.fasta fasta_dir/.
cp /tahoma/emsla60288/edo/openfold/openfold.simg .
singularity exec ./openfold.simg python3 /opt/openfold/run_pretrained_openfold.py --help 
/tahoma/emsla60288/edo/openfold/singularity_run.sh
exit 0
rm -rf alphafold
wget -q https://github.com/deepmind/alphafold/tarball/main -O - | tar -xz
ln -sf deepmind-alphafold-??????? alphafold
export DOWNLOAD_DIR=/tahoma/datasets/alphafold
#export DOWNLOAD_DIR=/tahoma/edo/alphafold_dir
export ALPHAFOLD_DIR=`pwd`/alphafold
singularity pull -F --name $ALPHAFOLD_DIR/alphafold.sif   oras://ghcr.io/edoapra/alphafold_singularity/alphafold:latest
ls -lrt $ALPHAFOLD_DIR/alphafold.sif
export MODFILES_DIR=$org_dir
mkdir -p /tmp/alphafold
export TMPDIR=/tmp/alphafold
python -m pip install --upgrade pip
python -m pip install absl-py spython
cp $MODFILES_DIR/* .
ls -lrt
/usr/bin/time -p python ./run_singularity.py \
  --fasta_paths=benchmark_24aas.fasta \
  --max_template_date=2022-05-14 \
--model_preset=monomer \
  --data_dir=$DOWNLOAD_DIR
cp -rp $TMPDIR $org_dir/tmp.$SLURM_JOBID
