#!/bin/bash
export PATH=/tahoma/emsla60288/edo/py3714/bin/:$PATH
if [ -d  "venv3714" ]; then
    echo "venv3714 directory present"
else
    python -m venv venv3714
fi
source venv3714/bin/activate
python -m pip install --upgrade pip
python -m pip install spython
DOWNLOAD_DIR=/tahoma/datasets/alphafold
singularity exec \
--nv \
--bind $PWD:/data \
--bind "$DOWNLOAD_DIR":/database \
./openfold.simg \
python3 /opt/openfold/run_pretrained_openfold.py \
/data/fasta_dir \
/database/pdb_mmcif/mmcif_files/ \
--uniref90_database_path /database/uniref90/uniref90.fasta \
--mgnify_database_path /database/mgnify/mgy_clusters_2018_12.fa \
--pdb70_database_path /database/pdb70/pdb70 \
--uniclust30_database_path /database/uniclust30/uniclust30_2018_08/uniclust30_2018_08 \
--output_dir /data \
--bfd_database_path /database/bfd/bfd_metaclust_clu_complete_id30_c90_final_seq.sorted_opt \
--model_device cuda:0 \
--jackhmmer_binary_path /opt/conda/bin/jackhmmer \
--hhblits_binary_path /opt/conda/bin/hhblits \
--hhsearch_binary_path /opt/conda/bin/hhsearch \
--kalign_binary_path /opt/conda/bin/kalign \
--openfold_checkpoint_path /database/openfold_params/finetuning_ptm_2.pt
