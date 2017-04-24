#!/bin/bash

set -e

ulimit -c unlimited

# 2 x 6 cores w/ hyperthreading

for DIR in $HOME/minisweep/openmp_build $HOME/minisweep/tasks_build; do
    for nthread_e in 6 12 24; do
        pushd $DIR

        export OMP_NUM_THREADS=$nthread_e

        echo "===== $DIR $nthread_e ====="
        ./sweep --ncell_x 16 --ncell_y 32 --ncell_z 32 \
            --nthread_e $nthread_e --ne 64 --na 32 --nblock_z 32

        popd
        echo
    done

    echo
done
