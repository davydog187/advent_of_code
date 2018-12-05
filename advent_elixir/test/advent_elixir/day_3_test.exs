defmodule AdventElixir.Day3Test do
  use ExUnit.Case
  doctest AdventElixir.Day3, import: true

  describe "day 3" do
    setup do
      {:ok, fixture: read_input("../fixtures/day_3.txt")}
    end

    test "a", %{fixture: input} do
      assert AdventElixir.Day3.count(input) == 110_827
    end

    test "b", %{fixture: input} do
      assert AdventElixir.Day3.find(input) == 116
    end
  end

  defp read_input(path) do
    Path.join([__DIR__, path])
    |> File.read!()
  end
end
