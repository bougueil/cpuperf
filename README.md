# Cpuperf

## a measuring tool for the Erlang VM

  Given an integer n, returns the time in `ms` to execute an algorithm with n (time increases with n).
  
  I use it to compare multi-cores erlang nodes.

## Usage
```
  cd cpuperf/
  mix escript.build
  NUM_ITERS=300
  ./cpuperf $NUM_ITERS
```
```
$ ./cpuperf 300
$ 919.072
```
