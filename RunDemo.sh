#!/bin/bash

Model=Demo
ModelXML=./vfgen/${Model}_vf.xml
ModelSO=./C/${Model}.so
ModelHDF5=./data/${Model}.h5
SampleFile="`date +%Y-%m-%dT%Hh%Mm`.h5"
# number of workers
NP=${1:-8}
DefaultSampleSize=$((2**11))
DefaultWarmUp=$((2**10))
SampleSize=${2:-$DefaultSampleSize}
WarmUp=${3:-$DefaultWarmUp}
StepSize="0.0001";
M=1.5

export OMP_NUM_THREADS=2

P=`h5dump -A -d /prior/mu ${ModelHDF5} | egrep DATASPACE | sed -E 's/.*\{\s*\( ([0-9]+).*/\1/'`
T0="-50"

MCMC_SIZE="-w ${WarmUp} -s ${SampleSize}"
MCMC_PARAMETERS="-i ${StepSize} -m $M ${RESUME:+--resume}"
PARALLEL_TEMPERING="-p -g 4"
ODE_PARAMETERS="--sens-approx --abs-tol 1e-3 --rel-tol 1e-3 --init-at-t ${T0}"
MCMC_FILES="-o ${SampleFile} -l ${ModelSO} --hdf5 ${ModelHDF5}"
OPTIONS="${MCMC_SIZE} ${MCMC_FILES} ${MCMC_PARAMETERS} ${PARALLEL_TEMPERING} ${ODE_PARAMETERS}"

cat<<EOF
$0
 redirecting standard output to $Model.out
 redirecting standard error  to $Model.err

      MPI workers: ${NP}
   OpenMP Threads: ${OMP_NUM_THREADS:-automatic}

 output will be one hdf5 file per MPI proc,
 ending with .. ${SampleFile}

 Number of parameters: ${P}

 to load the sample in matlab or GNU Octave 
 use the «load» function; in matlab, use hdf5read.

 sampling now ...
EOF




MPICMD=mpirun
SMMALA="${HOME}/mcmc_clib/bin/ode_smmala"
# the actual parameter estimation:
$MPICMD -np $NP $SMMALA $OPTIONS 1> ${Model}.out 2> ${Model}.err 
