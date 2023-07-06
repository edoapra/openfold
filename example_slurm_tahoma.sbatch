#!/bin/bash
#SBATCH -t 9:59:00
#SBATCH -N 1
#SBATCH -A XXYYZZ
#SBATCH -p analysis 
#SBATCH -o openfold_training.output.%j
#SBATCH -e openfold_training.output.%j
#SBATCH -J preallmms
source /etc/profile.d/modules.sh
module purge
module load gcc
export https_proxy=http://proxy.emsl.pnl.gov:3128
export http_proxy=http://proxy.emsl.pnl.gov:3128
echo start `date`
./singularity_training.sh
echo end `date`
