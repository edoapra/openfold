#!/bin/bash
#SBATCH -t 10:59:00
#SBATCH -N 1
#SBATCH -A emsla60288
#SBATCH -p analysis 
#SBATCH -o openfold.output.%j
#SBATCH -e openfold.output.%j
#SBATCH -J preallmms
source /etc/profile.d/modules.sh
module purge
module load gcc
export https_proxy=http://proxy.emsl.pnl.gov:3128
export http_proxy=http://proxy.emsl.pnl.gov:3128
./singularity_training.sh
