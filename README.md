```bash
PATH=/scratch/luiss/tmp3/delete2/parallel-subset/arc-gnu-toolchain/scripts/wrapper/qemu:$PATH DEJAGNU=/scratch/luiss/tmp3/delete2/parallel-subset/arc-gnu-toolchain/dejagnu/site.exp QEMU_CPU=archs  make check -j32 RUNTESTFLAGS="--target_board=arc-sim --ignore 'plugin.exp gcov.exp'"
```
