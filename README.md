# Cpuperf

## a CPU Benchmark tool for the Erlang VM

  A simple tool to display the time to do a multi-core computation.

  The tool has one parameter `NUM_ITERS`that augments the computation if higher.

## Usage
```
  git clone https://github.com/bougueil/cpuperf.git
  cd cpuperf/
  NUM_ITERS=600
  ./show_vm_cpu_perf $NUM_ITERS

  Erlang/OTP 24 [erts-12.0.3]
  CPU model:  Intel(R) Core(TM) i9-10885H CPU @ 2.40GHz
  1 CPU,  8 physical cores per CPU, total 16 logical CPU units
  computing time (ms.) on OTP 24 erts-12.0.3 to execute 600 iterations: 1027.558
```

## fixing the number of schedulers online
```
  ./show_vm_cpu_perf $NUM_ITERS 1   # 1 scheduler online

Erlang/OTP 24 [erts-12.0.3]
  CPU model:  Intel(R) Core(TM) i9-10885H CPU @ 2.40GHz
  1 CPU,  8 physical cores per CPU, total 16 logical CPU units
  NUM_SCHEDULER_ONLINE:1
  computing time (ms.) on OTP 24 erts-12.0.3 to execute 600 iterations: 7732.066
```
