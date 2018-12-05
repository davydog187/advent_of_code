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
        {number, ""} ->
          total + number

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
        {num, _} ->
          num

        :error ->
          raise "could not parse #{inspect(val)}"
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

  @doc """
  iex> ids = ["abcdef", "bababc", "abbcde", "abcccd", "aabcdd", "abcdee", "ababab"]
  iex> day_2a(ids)
  12
  """
  def day_2a(ids) do
    {twos, threes} =
      Enum.reduce(ids, {0, 0}, fn id, {twos, threes} ->
        {increase_two?, increase_three?} =
          id
          |> split_word()
          |> count_id()

        {
          if(increase_two?, do: twos + 1, else: twos),
          if(increase_three?, do: threes + 1, else: threes)
        }
      end)

    twos * threes
  end

  def split_word(word) do
    String.graphemes(word)
  end

  @doc """
  iex> count_id(split_word("abcdef"))
  {false, false}

  iex> count_id(split_word("bababc"))
  {true, true}

  iex> count_id(split_word("abbcde"))
  {true, false}

  iex> count_id(split_word("abcccd"))
  {false, true}

  iex> count_id(split_word("aabcdd"))
  {true, false}

  iex> count_id(split_word("abcdee"))
  {true, false}

  iex> count_id(split_word("ababab"))
  {false, true}
  """
  def count_id(id) do
    counts =
      Enum.reduce(id, Map.new(), fn letter, counts ->
        Map.update(counts, letter, 1, &(&1 + 1))
      end)

    two = Enum.any?(counts, fn {_k, val} -> val == 2 end)
    three = Enum.any?(counts, fn {_k, val} -> val == 3 end)

    {two, three}
  end

  @doc """
  iex> ids = ["abcde", "fghij", "klmno", "pqrst", "fguij", "axcye", "wvxyz"]
  iex> day_2b(ids)
  "fgij"
  """
  def day_2b(ids) do
    {a, b} =
      Enum.find_value(ids, fn id ->
        found = Enum.find(ids, fn x -> difference(id, x) == 1 end)

        if found do
          {id, found}
        end
      end)

    Enum.zip(split_word(a), split_word(b))
    |> Enum.reduce([], fn {a, b}, acc ->
      if a == b do
        [a | acc]
      else
        acc
      end
    end)
    |> Enum.reverse()
    |> Enum.join("")
  end

  @doc """
  iex> difference("abc", "abd")
  1

  iex> difference("abc", "acb")
  2
  """
  def difference(a, b) do
    Enum.zip(split_word(a), split_word(b))
    |> Enum.reduce(0, fn {a, b}, count ->
      if a == b do
        count
      else
        count + 1
      end
    end)
  end
end
