defmodule AdventElixir do
  @moduledoc """
  Documentation for AdventElixir.
  """

  @doc """
  iex> day_1a(["+1", "+1", "+1"])
  3

  iex> day_1a(["+1", "+1", "-2"])
  0

  iex> day_1a(["-1", "-2", "-3"])
  -6
  """
  def day_1a(frequencies) do
    Enum.reduce(frequencies, 0, fn frequency, total ->
      case Integer.parse(frequency) do
        {number, ""} -> total + number
        :error ->
          total
      end
    end)
  end

  @doc """
  iex> day_1b(["+1", "-1"])
  0

  iex> day_1b(["+3", "+3", "+4", "-2", "-4"])
  10

  iex> day_1b(["-6", "+3", "+8", "+5", "-6"])
  5

  iex> day_1b(["+7", "+7", "-2", "-7", "-4"])
  14
  """
  def day_1b(frequencies) do
    frequencies
    |> Stream.map(fn val ->
      case Integer.parse(val) do
        {num, _} -> num
        :error ->
          raise "could not parse #{inspect val}"
      end
    end)
    |> Stream.cycle()
    |> Enum.reduce_while({0, MapSet.new([0])}, fn val, {total, totals} ->
      total = total + val

      if MapSet.member?(totals, total) do
        {:halt, total}
      else
        {:cont, {total, MapSet.put(totals, total)}}
      end
    end)
  end

end
