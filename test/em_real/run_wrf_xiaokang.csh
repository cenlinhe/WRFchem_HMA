#!/bin/tcsh
#PBS -N wrf
#PBS -A UTXC0003
#PBS -l walltime=12:00:00
#PBS -q economy
#PBS -j oe
#PBS -m abe
#PBS -M xwu44@ucar.edu
#PBS -l select=2:ncpus=36:mpiprocs=36

### Run the executable
mpiexec_mpt dplace -s 1 ./wrf.exe
