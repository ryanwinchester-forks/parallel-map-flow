defmodule Dist do
  @moduledoc """
  Documentation for `Dist`.
  """

  @doc """
  A generic "work parallelizer."

  ## Examples

      iex> Dist.run([1, 2, 3], &(&1 * 2), & &1)
      [2, 4, 6]

      iex> Dist.run([1, 2, 3], fn chunk -> Enum.map(chunk, &(&1 * 2)) end, &Stream.chunk_every(&1, 2))
      [2, 4, 6]

  """
  def run(data, work_fun, dist_fun) do
    data
    |> dist_fun.()
    |> Flow.from_enumerable()
    |> Flow.map(work_fun)
    |> Enum.to_list()
    |> List.flatten()
  end
end
