#!/bin/bash
#module purge
#module load python/3.8.1
#  module load gcc/9.3.0
  nohup apptainer build --force --fakeroot /tmp/openfold.simg Singularity.def
rsync -av /tmp/openfold.simg .
