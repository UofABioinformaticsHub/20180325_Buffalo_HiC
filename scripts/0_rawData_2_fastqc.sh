#!/bin/bash
#SBATCH -p batch
#SBATCH -N 1
#SBATCH -n 6
#SBATCH --time=2:00:00
#SBATCH --mem=32GB
#SBATCH -o /data/biohub/20180325_Buffalo_HiC/slurm/0_rawData_fastqc_%j.out
#SBATCH -e /data/biohub/20180325_Buffalo_HiC/slurm/0_rawData_fastqc_%j.err
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=stephen.pederson@adelaide.edu.au

# Load all modules
module load fastqc/0.11.4

## Directories
ROOT=/data/biohub/20180325_Buffalo_HiC
RAWDATA=${ROOT}/0_rawData/fastq
FQCDIR=${ROOT}/0_rawData/FastQC

## Adapters
ADAPTERS=${ROOT}/0_rawData/adapters/adapters.txt

# Run fastqc
fastqc -t 6 -a ${ADAPTERS} -o ${FQCDIR} --noextract ${RAWDATA}/*gz
