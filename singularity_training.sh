#!/bin/bash
export ORGDIR=`pwd`
export WORKDIR=/big_scratch
export OUTDIR=`pwd`/out.$SLURM_JOBID
export https_proxy=http://proxy.emsl.pnl.gov:3128
export http_proxy=http://proxy.emsl.pnl.gov:3128
export DOWNLOAD_DIR=/tahoma/emsla60288/edo/openfold/data
export MMSEQS_NUM_THREADS=8
cd $WORKDIR
rsync -av $ORGDIR/scripts .
singularity pull -F --name openfold.simg oras://ghcr.io/edoapra/openfold/openfold:latest
singularity exec \
--nv \
--bind $PWD:/data \
--bind "$DOWNLOAD_DIR":/database \
./openfold.simg \
	    python3 /opt/openfold/scripts/precompute_alignments_mmseqs.py \
	    /database/test_fasta_dir/benchmark_24aas.fasta \
	    /database/mmseqs_dbs \
	        uniref30_2103_db \
    $OUTDIR \
    /opt/conda/bin/mmseqs \
    --hhsearch_binary_path /opt/conda/bin/hhsearch \
    --env_db colabfold_envdb_202108_db \
    --pdb70 /database/pdb70/pdb70 

rsync --exclude=openfold.simg -av  *  $OUTDIR/.
exit 0

#    /opt/conda/bin/hhsearch \
#python3 scripts/precompute_alignments_mmseqs.py --help  
#usage: precompute_alignments_mmseqs.py [-h]
#                                       [--hhsearch_binary_path HHSEARCH_BINARY_PATH]
#                                       [--pdb70 PDB70] [--env_db ENV_DB]
#                                       [--fasta_chunk_size FASTA_CHUNK_SIZE]
#                                       input_fasta mmseqs_db_dir uniref_db
#                                       output_dir mmseqs_binary_path
#
#positional arguments:
#  input_fasta           Path to input FASTA file. Can contain one or more
#                        sequences.
#  mmseqs_db_dir         Path to directory containing pre-processed MMSeqs2 DBs
#                        (see README)
#  uniref_db             Basename of uniref database
#  output_dir            Output directory
#  mmseqs_binary_path    Path to mmseqs binary
#
#optional arguments:
#  -h, --help            show this help message and exit
#  --hhsearch_binary_path HHSEARCH_BINARY_PATH
#                        Path to hhsearch binary (for template search). In
#                        future versions, we'll also use mmseqs for this
#  --pdb70 PDB70         Basename of the pdb70 database
#  --env_db ENV_DB       Basename of environmental database
#  --fasta_chunk_size FASTA_CHUNK_SIZE
#                        How many sequences should be processed at once. All
#                        sequences processed at once by default.
#
