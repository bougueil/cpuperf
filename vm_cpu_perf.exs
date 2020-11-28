defmodule VmCpuBench do
  @moduledoc """
  a measuring tool for the Erlang VM

  Given an integer n  (number of iterations) as input, returns the time in `ms` to run the algorithm with n.
  The calculated time increases non linearly with n, try with low number like 300.
  I use it to compare vm on different hardwares and dimension loads.
  """

  def run(n) do
    (fn n ->
       self = self()

       g = fn
         _, 0, _, l ->
           l

         g1, n1, ref, l ->
           receive do
             {^ref, ret} -> g1.(g1, n1 - 1, ref, [ret | l])
           end
       end

       ref = make_ref()

       l = for _ <- 1..n, do: :rand.uniform(1000)
       fw = fn -> send(self, {ref, List.foldl(l, 1, fn _j, _a -> Enum.sort(l) end)}) end

       {t, _v} =
         :timer.tc(fn ->
           for _i <- l, do: spawn(fw)
           g.(g, length(l), ref, [])
         end)

       t / 1000
     end).(n)
  end
end

iters =
  IO.gets('')
  |> String.trim_trailing()
  |> String.to_integer()

VmCpuBench.run(iters)
|> IO.inspect(label: "computing time (ms.) to execute #{iters} iterations")
