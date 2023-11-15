# Cpuperf

## a CPU Benchmark tool for the Erlang VM

A simple tool to display the time to do a multi-core computation.

The tool has one parameter: `NUM_ITERS`that increase the computation workload if higher.

## Usage
```
git clone https://github.com/bougueil/cpuperf.git
cd cpuperf/
NUM_ITERS=600
./show_vm_cpu_perf $NUM_ITERS

CPU model:  12th Gen Intel(R) Core(TM) i5-1235U
1 CPU,  10 physical cores per CPU, total 12 logical CPU units
System and architecture:
  Elixir version     1.17.0-dev
  Erlang/OTP version 26
  ERTS version       14.1.1
  Compiled for       x86_64-pc-linux-gnu
  Schedulers         12
  Schedulers online  12
  Computing time (ms.) to execute 600 iterations : 1291.426
```

## setting the number of schedulers online
```
./show_vm_cpu_perf $NUM_ITERS 1   # 1 scheduler online

CPU model:  12th Gen Intel(R) Core(TM) i5-1235U
1 CPU,  10 physical cores per CPU, total 12 logical CPU units
NUM_SCHEDULER_ONLINE:1
System and architecture:
  Elixir version     1.17.0-dev
  Erlang/OTP version 26
  ERTS version       14.1.1
  Compiled for       x86_64-pc-linux-gnu
  Schedulers         1
  Schedulers online  1
  Computing time (ms.) to execute 600 iterations : 4767.23

```
