defmodule AdventElixirTest do
  use ExUnit.Case
  doctest AdventElixir, import: true

  test "day one" do
    input =
      Path.join([__DIR__, "./fixtures/day_1.txt"])
      |> File.read!()
      |> String.split("\n")

    assert AdventElixir.day_1(input) == 5
  end

end
