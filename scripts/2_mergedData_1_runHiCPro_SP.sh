#!/bin/bash
#SBATCH -p skylake
#SBATCH -N 1
#SBATCH -n 20
#SBATCH --time=48:00:00
#SBATCH --mem=80GB
#SBATCH -o /data/biohub/20180325_Buffalo_HiC/slurm/2_mergedData_1_runHicPro_SP_%j_out.txt
#SBATCH -e /data/biohub/20180325_Buffalo_HiC/slurm/2_mergedData_1_runHicPro_SP_%j_err.txt
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=a108048@adelaide.edu.au

## Bash script to run HiC-pro 
## By Ning Liu, modified by Steve Pederson

## Load modules 
module load HiC-Pro/2.9.0-foss-2016b

## Define the root for the analysos
ROOTDIR=/data/biohub/20180325_Buffalo_HiC

##Run HiC-pro
HiC-Pro -c ${ROOTDIR}/ext/config-buffalo.txt \
  -i ${ROOTDIR}/2_mergedData \
  -o ${ROOTDIR}/4a_HiCMerged
