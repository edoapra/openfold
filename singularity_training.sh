#!/bin/bash
CUDA_DIR=/tahoma/emsla60288/edo/cuda-11.3
export LD_LIBRARY_PATH=$CUDA_DIR/lib64:$LD_LIBRARY_PATH
export DOWNLOAD_DIR=/tahoma/emsla60288/edo/openfold/data
mkdir -p alignment_dir
singularity exec \
--nv \
--bind $PWD:/data \
--bind "$DOWNLOAD_DIR":/database \
./openfold.simg \
	    python3 /opt/openfold/scripts/precompute_alignments_mmseqs.py \
	    /database/benchmark_24aas.fasta \
	    /database/mmseqs_dbs \
	        uniref30_2103_db \
    /data/alignment_dir \
    /opt/MMseqs2/build/src/mmseqs \
    --env_db colabfold_envdb_202108_db \
    --pdb70 data/pdb70/pdb \
