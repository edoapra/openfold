#!/bin/bash
#SBATCH -t 0:59:00
#SBATCH -N 1
#SBATCH -A XXYYZZ
#SBATCH -p analysis 
#SBATCH -o openfold_inference.output.%j
#SBATCH -e openfold_inference.output.%j
#SBATCH -J of1
source /etc/profile.d/modules.sh
module purge
module load gcc
export https_proxy=http://proxy.emsl.pnl.gov:3128
export http_proxy=http://proxy.emsl.pnl.gov:3128
/usr/bin/time -p ./singularity_inference.sh
