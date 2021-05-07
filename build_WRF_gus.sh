#!/bin/sh
## Clean environment
#./clean -a
## Loading modules in Cheyenne
#module load gnu/6.3.0
module load intel
module load grib-libs

## WRF settings
export WRF_EM_CORE=1
export WRF_NMM_CORE=0
export WRF_DA_CORE=0
## WRF/Chem settings
export WRF_CHEM=1
export WRF_KPP=1
export FLEX_LIB_DIR=/usr/lib64
export YACC="/usr/bin/yacc -d"
export WRFIO_NCD_LARGE_FILE_SUPPORT=1

## Setting environment
#export HDF5=/glade/u/apps/ch/modulefiles/default/gnu/6.3.0/hdf5
export HDF5=/glade/u/apps/ch/modulefiles/default/intel/16.0.1/hdf
export JASPERINC=/glade/u/home/wrfhelp/UNGRIB_LIBRARIES/inc
export JASPERLIB=/glade/u/home/wrfhelp/UNGRIB_LIBRARIES/lib
#./configure
./compile em_real |& tee compile.log
