#!/bin/bash
#SBATCH -p batch
#SBATCH -N 1
#SBATCH -n 1
#SBATCH --time=2:00:00
#SBATCH --mem=32GB
#SBATCH -o /data/biohub/20180325_Buffalo_HiC/slurm/0_rawData_findAdapters_%j.out
#SBATCH -e /data/biohub/20180325_Buffalo_HiC/slurm/0_rawData_findAdapters_%j.err
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=stephen.pederson@adelaide.edu.au

# Load BBmerge
module load BBMap/36.62-intel-2017.01-Java-1.8.0_121

# Define the dirs
RAWDIR=/data/biohub/20180325_Buffalo_HiC/0_rawData

# Get the pairs
for f1 in ${RAWDIR}/fastq/*R1.fastq.gz
  do
    echo "Found ${f1}"
    f2=${f1%R1.fastq.gz}R2.fastq.gz
    echo "The R2 file should be ${f2}"
    OUT=${RAWDIR}/$(basename ${f1%R1.fastq.gz}adapters.fa)
    echo "Adapters will be written to ${OUT}"
    LOG=${OUT%adapters.fa}bbmerge.log
    echo "BBMerge summaries will be written to ${LOG}"

    bbmerge.sh in1=${f1} in2=${f2} outa=${OUT} > ${LOG}

  done
