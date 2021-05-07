#!/bin/tcsh
#PBS -N real
#PBS -A UMIT0006
#PBS -l walltime=01:00:00
#PBS -q premium
#PBS -j oe
#PBS -m abe
#PBS -M xwu44@ucar.edu
#PBS -l select=2:ncpus=36:mpiprocs=36

### Run the executable
mpiexec_mpt dplace -s 1 ./real.exe
