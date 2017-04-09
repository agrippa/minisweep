#!/bin/bash -l

#SBATCH -p debug
#SBATCH -N 1
#SBATCH -t 00:05:00
#SBATCH -J minisweep
#SBATCH --exclusive
#SBATCH --mail-type=ALL
#SBATCH --contiguous

ulimit -c unlimited

export nproc_x=2
export nproc_y=2
export PES_PER_NODE=2
export NPES=$(($PES_PER_NODE * $SLURM_NNODES))
export CPUS_PER_PE=12
export OMP_NUM_THREADS=$CPUS_PER_PE

for DIR in $HOME/minisweep/build $HOME/minisweep/build.tasks; do
    pushd $DIR

    srun --ntasks=1 --ntasks-per-node=1 --cpus-per-task=24 ./sweep \
        --ncell_x $(( 4 * $nproc_x )) --ncell_y $(( 8 * $nproc_y )) \
        --ncell_z 64 --ne 16 --na 32 --nblock_z 64

    popd
    echo
done
