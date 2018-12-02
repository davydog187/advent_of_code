defmodule AdventElixir do
  @moduledoc """
  Documentation for AdventElixir.
  """

  @doc """
  iex> day_1(["+1", "+1", "+1"])
  3

  iex> day_1(["+1", "+1", "-2"])
  0

  iex> day_1(["-1", "-2", "-3"])
  -6
  """
  def day_1(frequencies) do
    Enum.reduce(frequencies, 0, fn frequency, total ->
      case Integer.parse(frequency) do
        {number, ""} -> total + number
        :error ->
          total
      end
    end)
  end

end
