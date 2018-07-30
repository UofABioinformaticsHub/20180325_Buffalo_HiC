#!/bin/bash

## Bash script to merge the technical replicate fastq files
## into a single file, after adapter removal, by Steve Pederson

## Define the root for the analysis
## Each sample just needs to have 5, 6 or 7 added to this
ROOTDIR=/data/biohub/20180325_Buffalo_HiC/1_trimmedData/fastq/CP-493

## Define where the merged files will go
MERGEDIR=/data/biohub/20180325_Buffalo_HiC/2_mergedData/fastq

echo "Merging R1 files"
cat ${ROOTDIR}5/*R1.fastq.gz ${ROOTDIR}6/*R1.fastq.gz ${ROOTDIR}7/*R1.fastq.gz > ${MERGEDIR}/allSamples_R1.fastq.gz

echo "Merging R2 files"
cat ${ROOTDIR}5/*R2.fastq.gz ${ROOTDIR}6/*R2.fastq.gz ${ROOTDIR}7/*R2.fastq.gz > ${MERGEDIR}/allSamples_R2.fastq.gz

