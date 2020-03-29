# Cpuperf

## a measuring tool for the Erlang VM

  Given an integer n (number of iterations) as input, returns the time in `ms` to run the algorithm with n.
  The calculated time increases non linearly with n, try with low number like 300.

I use it to compare vm on different hardwares and dimension loads.

## Usage
```
  git clone https://github.com/bougueil/cpuperf.git
  cd cpuperf/
  NUM_ITERS=300
  ./show_vm_cpu_perf $NUM_ITERS
```
```
CPU model:  Intel(R) Core(TM) i5-6200U CPU @ 2.30GHz
1 CPU,  2 physical cores per CPU, total 4 logical CPU units
computing time in ms to execute 300 iterations
961.217
```
