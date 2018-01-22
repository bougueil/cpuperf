# Cpuperf

## a measuring tool for the Erlang VM

  Given an integer n, returns the time in `ms` to execute an algorithm with n (time increases with n).
  
  I use it to compare multi-cores erlang nodes.

## Usage
```
  cd cpuperf/
  NUM_ITERS=300
  ./show_cpuperf $NUM_ITERS 
```
```
CPU model:  Intel(R) Core(TM) i5-6200U CPU @ 2.30GHz
1 CPU,  2 physical cores per CPU, total 4 logical CPU units
cpuperf with 300 iterations: **961.217**
```
