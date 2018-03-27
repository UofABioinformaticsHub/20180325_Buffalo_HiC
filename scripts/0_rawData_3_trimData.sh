#!/bin/bash
#SBATCH -p batch
#SBATCH -N 1
#SBATCH -n 16
#SBATCH --time=20:00:00
#SBATCH --mem=32GB
#SBATCH -o /data/biohub/20180325_Buffalo_HiC/slurm/0_rawData_3_trimData_%j.out
#SBATCH -e /data/biohub/20180325_Buffalo_HiC/slurm/0_rawData_3_trimData_%j.err
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=stephen.pederson@adelaide.edu.au

## Modules
module load fastqc/0.11.4
module load AdapterRemoval/2.2.1-foss-2016b

## Directories
ROOT=/data/biohub/20180325_Buffalo_HiC
RAWDIR=${ROOT}/0_rawData
TRIMDIR=${ROOT}/1_trimmedData

## Making directories for Trimmed data
mkdir -p ${TRIMDIR}/fastq
mkdir -p ${TRIMDIR}/FastQC

## Cores
CORES=16

##--------------------------------------------------------------------------------------------##
## Trimming the Merged data
##--------------------------------------------------------------------------------------------##

for f1 in ${RAWDIR}/fastq/*R1.fastq.gz
  do
    # Set the input filenames
    echo "Found ${f1}"
    f2=${f1%R1.fastq.gz}R2.fastq.gz
    echo "The R2 file should be ${f2}"
 
    # Set the output filenames
    out1=${TRIMDIR}/fastq/$(basename ${f1})
    out2=${TRIMDIR}/fastq/$(basename ${f2})
    echo -e "Trimmed files will be written to\n\t${out1} and \n\t${out2}"

    # Remove the adapters. 
    # This dataset uses TrueSeq adapters so we don't need to specify them
    AdapterRemoval \
      --gzip \
      --trimqualities \
      --minquality 20 \
      --minlength 50 \
      --maxns 1 \
      --threads ${CORES} \
      --output1 ${out1} \
      --output2 ${out2} \
      --file1 ${f1} \
      --file2 ${f2} 

  done

fastqc -t ${CORES} -o ${TRIMDIR}/FastQC --noextract ${TRIMDIR}/fastq/*
