#!bin/bash
#SBATCH -p skylake
#SBATCH -N 1
#SBATCH -n 16
#SBATCH --time=4:00:00
#SBATCH --mem=64GB
#SBATCH -o /data/biohub/20180325_Buffalo_HiC/slurm/%j-out.txt
#SBATCH -e /data/biohub/20180325_Buffalo_HiC/slurm/%j-err.txt
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=a1018048@adelaide.edu.au

# Written by Ning Liu & Steve Pedesron

# to prepare all the reference files for HiC-Pro
module load SAMtools/1.3.1-foss-2016b
module load Bowtie2/2.2.9-foss-2016b
module load Python/2.7.13-foss-2016b 

# add 'chr' at the front of each fasta sequence
sed 's/^/^chr/g' Ref/Buffalo/water_buffalo_20180219.fasta > Ref/Buffalo/water_buffalo_20180219_chr.fasta

# build the bowtie2 index
bowtie2-build -f water_buffalo_20180219_chr.fasta --threads 16 water_buffalo_20180219

# get chrom size
samtools faidx water_buffalo_20180219_chr.fasta
cut -f1,2 water_buffalo_20180219_chr.fasta > Ref/Buffalo/buffalo.sizes

# get restriction fragments
python ext/digest_genome.py -r G^CTAGC -o Ref/Buffalo/Buffalo_NheI_fragment.bed Ref/Buffalo/water_buffalo_20180219_chr.fasta

