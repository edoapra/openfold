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
singularity exec \
--bind $PWD:/data \
--bind "$DOWNLOAD_DIR":/database \
./openfold.simg \
	    python3 /opt/openfold/scripts/precompute_alignments.py \
	    /data/benchmark_24aas.fasta \
	    /data/mmseqs_dbs \
	        uniref30_2103_db \
    alignment_dir \
    ~/MMseqs2/build/bin/mmseqs \
    /usr/bin/hhsearch \
    --env_db colabfold_envdb_202108_db
    --pdb70 data/pdb70/pdb \
--uniref90_database_path /database/uniref90/uniref90.fasta \
--mgnify_database_path /database/mgnify/mgy_clusters_2018_12.fa \
--pdb70_database_path /database/pdb70/pdb70 \
	    --uniclust30_database_path /database/uniclust30/uniclust30_2018_08/uniclust30_2018_08 
#usage: precompute_alignments.py [-h] [--uniref90_database_path UNIREF90_DATABASE_PATH] [--mgnify_database_path MGNIFY_DATABASE_PATH]
#                                [--pdb70_database_path PDB70_DATABASE_PATH] [--uniclust30_database_path UNICLUST30_DATABASE_PATH]
#                                [--bfd_database_path BFD_DATABASE_PATH] [--jackhmmer_binary_path JACKHMMER_BINARY_PATH]
#                                [--hhblits_binary_path HHBLITS_BINARY_PATH] [--hhsearch_binary_path HHSEARCH_BINARY_PATH]
#                                [--kalign_binary_path KALIGN_BINARY_PATH] [--max_template_date MAX_TEMPLATE_DATE]
#                                [--obsolete_pdbs_path OBSOLETE_PDBS_PATH] [--release_dates_path RELEASE_DATES_PATH] [--raise_errors]
#                                [--cpus_per_task CPUS_PER_TASK] [--mmcif_cache MMCIF_CACHE] [--no_tasks NO_TASKS] [--filter FILTER]
#                                input_dir output_dir
#
#positional arguments:
#  input_dir             Path to directory containing mmCIF, FASTA and/or ProteinNet .core files
#  output_dir            Directory in which to output alignments
#
#optional arguments:
#  -h, --help            show this help message and exit
#  --uniref90_database_path UNIREF90_DATABASE_PATH
#  --mgnify_database_path MGNIFY_DATABASE_PATH
#  --pdb70_database_path PDB70_DATABASE_PATH
#  --uniclust30_database_path UNICLUST30_DATABASE_PATH
#  --bfd_database_path BFD_DATABASE_PATH
#  --jackhmmer_binary_path JACKHMMER_BINARY_PATH
#  --hhblits_binary_path HHBLITS_BINARY_PATH
#  --hhsearch_binary_path HHSEARCH_BINARY_PATH
#  --kalign_binary_path KALIGN_BINARY_PATH
#  --max_template_date MAX_TEMPLATE_DATE
#  --obsolete_pdbs_path OBSOLETE_PDBS_PATH
#  --release_dates_path RELEASE_DATES_PATH
#  --raise_errors        Whether to crash on parsing errors
#  --cpus_per_task CPUS_PER_TASK
#                        Number of CPUs to use
#  --mmcif_cache MMCIF_CACHE
#                        Path to mmCIF cache. Used to filter files to be parsed
#  --no_tasks NO_TASKS
#  --filter FILTER
#Singularity> 
