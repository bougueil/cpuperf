defmodule Run do
  def main(args) do
    res = args |> hd |> String.to_integer() |> CpuPerf.bench()
    IO.puts("#{res}")
  end
end

defmodule CpuPerf do
  @moduledoc """
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
  """

  @doc """
  """
  def bench(n) do
    (fn n ->
       s = self()

       g = fn
         _, 0, _, l ->
           l

         g1, n1, ref, l ->
           receive do
             {^ref, ret} -> g1.(g1, n1 - 1, ref, [ret | l])
           end
       end

       ref = Kernel.make_ref()

       l = for _ <- 1..n, do: :rand.uniform(1000)
       fw = fn -> send(s, {ref, List.foldl(l, 1, fn _j, _a -> Enum.sort(l) end)}) end

       {t, _v} =
         :timer.tc(fn ->
           for _i <- l, do: spawn(fw)
           g.(g, length(l), ref, [])
         end)

       t / 1000
     end).(n)
  end
end
