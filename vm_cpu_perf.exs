defmodule VmCpuBench do
  @moduledoc """
  a measuring tool for the Erlang VM

  Given an integer `n` (number of iterations) as input, returns the time in `ms` to run the algorithm with n.
  The calculated time increases non linearly with n, try with low number like 300.
  I use it to compare vm on different hardwares and dimension loads.
  """

  def run(n) do
    numbers = for _ <- 1..n, do: :rand.uniform(1000)
    numbers_sz = length(numbers)
    self = self()

    recurse_fn = fn
      _, 0, acc ->
        acc

      g1, n1, acc ->
        receive do: (val -> g1.(g1, n1 - 1, [val | acc]))
    end

    worker_fn = fn ->
      send(self, List.foldl(numbers, 1, fn _, _a -> Enum.sort(numbers) end))
    end

    bench_fn = fn ->
      for _ <- numbers, do: spawn(worker_fn)
      recurse_fn.(recurse_fn, numbers_sz, [])
    end

    (fn ->
       bench_fn
       |> :timer.tc()
       |> elem(0)
       |> Kernel./(1000)
     end).()
  end
end

iters = IO.gets('') |> String.trim_trailing() |> String.to_integer()

VmCpuBench.run(iters)
|> IO.inspect(label: "computing time (ms.) on OTP #{System.otp_release()} to execute #{iters} iterations ")
