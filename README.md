```bash
PATH=/scratch/luiss/tmp3/delete2/parallel-subset/arc-gnu-toolchain/scripts/wrapper/qemu:$PATH DEJAGNU=/scratch/luiss/tmp3/delete2/parallel-subset/arc-gnu-toolchain/dejagnu/site.exp QEMU_CPU=archs  make check -j32 RUNTESTFLAGS="--target_board=arc-sim --ignore 'plugin.exp gcov.exp'"
```

### issues

ruby compare.rb -f gcc.sum -h /scratch/luiss/testing/workspace/hs5x-gcc-linux-user-qemu/build-gcc-linux-stage2/gcc/testsuite/gcc/:NATIVE -h /scratch/luiss/bsf/testing-gcc-parallel/workspace/hs5x-gcc-linux-qemu-user/testsuite/gcc/:PARALLEL -v
+--+-------------------------------------+----------------------------------------------------------+----------------------------------------------------------+
|  |                Delta                |                          NATIVE                          |                         PARALLEL                         |
+--+---------+---------+--------+--------+--------+------+-------+-------+------------+-------------+--------+------+-------+-------+------------+-------------+
|  | D(PASS) | D(FAIL) | D(NEW) | D(REM) | PASS   | FAIL | XFAIL | XPASS | UNRESOLVED | UNSUPPORTED | PASS   | FAIL | XFAIL | XPASS | UNRESOLVED | UNSUPPORTED |
+--+---------+---------+--------+--------+--------+------+-------+-------+------------+-------------+--------+------+-------+-------+------------+-------------+
|  | 18      | 3       | 88     | 1207   | 136358 | 18   | 1082  | 2     | 2          | 3280        | 135250 | 21   | 1069  | 1     | 2          | 3288        |
+--+---------+---------+--------+--------+--------+------+-------+-------+------------+-------------+--------+------+-------+-------+------------+-------------+
===  ===
  New fail
    (PASS) => (FAIL) : gcc.dg/tree-prof/time-profiler-2.c scan-ipa-dump-times profile "Read tp_first_run: 0" 2
    (PASS) => (FAIL) : gcc.dg/tree-prof/time-profiler-2.c scan-ipa-dump-times profile "Read tp_first_run: 2" 1
    (PASS) => (FAIL) : gcc.dg/tree-prof/time-profiler-2.c scan-ipa-dump-times profile "Read tp_first_run: 3" 1
