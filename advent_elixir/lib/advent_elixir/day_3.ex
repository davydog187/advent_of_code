defmodule AdventElixir.Day3 do
  @doc ~S'''
  iex> count("#1 @ 1,3: 4x4\n#2 @ 3,1: 4x4\n#3 @ 5,5: 2x2")
  4
  '''
  def count(input) do
    input
    |> parse_claims()
    |> Enum.reduce(Map.new(), fn line, matrix -> insert(matrix, line) end)
    |> Map.values()
    |> Enum.count(fn ids -> length(ids) > 1 end)
  end

  @doc ~S'''
  iex> find("#1 @ 1,3: 4x4\n#2 @ 3,1: 4x4\n#3 @ 5,5: 2x2")
  3
  '''
  def find(input) do
    parsed_claims = parse_claims(input)
    matrix = Enum.reduce(parsed_claims, Map.new(), fn line, matrix -> insert(matrix, line) end)

    {id, _, _, _, _} =
      Enum.find(parsed_claims, fn {id, left, top, width, height} ->
        Enum.all?(left..(left + width - 1), fn x ->
          Enum.all?(top..(top + height - 1), fn y ->
            Map.get(matrix, {x, y}) == [id]
          end)
        end)
      end)

    id
  end

  @doc """
  iex> insert(%{}, {5, 0, 0, 1, 1})
  %{{0, 0} => [5]}

  iex> insert(%{{0, 0} => [5]}, {7, 0, 0, 1, 1})
  %{{0, 0} => [7, 5]}
  """
  def insert(matrix, {_, _, _, _w, 0}) do
    matrix
  end

  def insert(matrix, {id, x, y, w, h}) do
    0..(w - 1)
    |> Enum.reduce(matrix, fn width, matrix ->
      Map.update(matrix, {x + width, y + h - 1}, [id], &[id | &1])
    end)
    |> insert({id, x, y, w, h - 1})
  end

  def parse_claims(claims) do
    claims
    |> String.split("\n", trim: true)
    |> Enum.map(&parse/1)
  end

  @doc """
  iex> parse("#1 @ 1,3: 4x4")
  {1, 1, 3, 4, 4}

  iex> parse("#2 @ 3,1: 4x4")
  {2, 3, 1, 4, 4}

  iex> parse("#3 @ 5,5: 2x2")
  {3, 5, 5, 2, 2}
  """
  def parse(line) do
    line
    |> String.split(["#", "@", ",", ":", "x", " "], trim: true)
    |> Enum.map(&parse_integer!/1)
    |> List.to_tuple()
  end

  defp parse_integer!(string) do
    {num, ""} = Integer.parse(string)
    num
  end
end
