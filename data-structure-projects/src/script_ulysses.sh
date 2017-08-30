#!/bin/bash
#PBS -l nodes=1:ppn=20
#PBS -l walltime=10:00:00

cd $PBS_O_WORKDIR

module load testing
module load gnu/6.2.0

#make 09 >> res_simple_sorting.txt
#make 10 >> res_bubble_sorting.txt
#make 11 >> res_insertion_sorting.txt
#make 12 >> res_quick_sorting.txt
#make 13 >> res_merge_sorting.txt
make 14 >> res_hybrid_sorting.txt
