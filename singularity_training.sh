#!/bin/bash
#export PATH=/tahoma/emsla60288/edo/py3714/bin/:$PATH
#if [ -d  "venv3714" ]; then
#    echo "venv3714 directory present"
#else
#    python -m venv venv3714
#fi
#source venv3714/bin/activate
#python -m pip install --upgrade pip
#python -m pip install spython
CUDA_DIR=/data/edo/cuda-11.3
export LD_LIBRARY_PATH=$CUDA_DIR/lib64:$LD_LIBRARY_PATH
#DOWNLOAD_DIR=/tahoma/datasets/alphafold/data
export DOWNLOAD_DIR=/data/edo/openfold-myfork/data
mkdir -p alignment_dir
singularity exec \
--bind $PWD:/data \
--bind "$DOWNLOAD_DIR":/database \
./openfold.simg \
	    python3 /opt/openfold/scripts/precompute_alignments_mmseqs.py \
	    /data/benchmark_24aas.fasta \
	    /database/mmseqs_dbs \
	        uniref30_2103_db \
    alignment_dir \
    ~/MMseqs2/build/bin/mmseqs \
    /usr/bin/hhsearch \
    --env_db colabfold_envdb_202108_db
    --pdb70 data/pdb70/pdb \
