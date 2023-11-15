defmodule VmCpuBench do
  @moduledoc """
  a measuring tool for the Erlang VM

  Given an integer `n` (number of iterations) as input, returns the time in `ms` to run the algorithm with n.
  The calculated time increases non linearly with n, try with low number like 300.
  """

  def run(n) do
    :rand.seed(:exsss, 0)
    numbers = for _ <- n..1, do: :rand.uniform(1000)
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
      recurse_fn.(recurse_fn, n, [])
    end

    (fn ->
       bench_fn
       |> :timer.tc()
       |> elem(0)
       |> Kernel./(1000)
     end).()
  end
end

iters = IO.gets("") |> String.trim_trailing() |> String.to_integer()

VmCpuBench.run(iters)
|> IO.inspect(label: "System and architecture:
  Elixir version     #{System.version()}
  Erlang/OTP version #{System.otp_release()}
  ERTS version       #{:erlang.system_info(:version)}
  Compiled for       #{:erlang.system_info(:system_architecture)}
  Schedulers         #{:erlang.system_info(:schedulers)}
  Schedulers online  #{:erlang.system_info(:schedulers_online)}
  Computing time (ms.) to execute #{iters} iterations ")
