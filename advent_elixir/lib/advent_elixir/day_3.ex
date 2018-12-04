defmodule AdventElixir.Day3 do
  @regex ~r/#(?<id>\d+) @ (?<x>\d+),(?<y>\d+): (?<w>\d+)x(?<h>\d+)/

  @doc ~S'''
  iex> input = "#1 @ 1,3: 4x4\n#2 @ 3,1: 4x4\n#3 @ 5,5: 2x2"
  iex> run(input)
  4
  '''
  def run(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.reduce(Map.new(), fn line, matrix -> insert(matrix, line) end)
    |> count_overlapping()
  end

  @doc """
  iex> insert(%{}, {{0, 0}, {1, 1}})
  %{{0, 0} => 1}
  """
  def insert(matrix, line) when is_binary(line) do
    details = parse(line)

    insert(matrix, details)
  end

  def insert(matrix, {_, {_w, 0}}) do
    matrix
  end

  def insert(matrix, {{x, y}, {w, h}}) do
    0..(w-1)
    |> Enum.reduce(matrix, fn width, matrix ->
      Map.update(matrix, {x + width, y + h - 1}, 1, & &1 + 1)
    end)
    |> insert({{x, y}, {w, h - 1}})
  end


  def count_overlapping(matrix) do
    matrix
    |> Map.values()
    |> Enum.count(fn x -> x > 1 end)
  end

  @doc """
  iex> parse("#1 @ 1,3: 4x4")
  {{1,3}, {4,4}}

  iex> parse("#2 @ 3,1: 4x4")
  {{3,1}, {4,4}}

  iex> parse("#3 @ 5,5: 2x2")
  {{5,5}, {2,2}}
  """
  def parse(line) do
    %{"x" => x, "y" => y, "w" => w, "h" => h} =
      Regex.named_captures(@regex, line)

    {{parse_integer!(x), parse_integer!(y)}, {parse_integer!(w), parse_integer!(h)}}
  end

  defp parse_integer!(string) do
    {num, ""} = Integer.parse(string)
    num
  end
end
