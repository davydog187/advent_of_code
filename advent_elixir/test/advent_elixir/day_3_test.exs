defmodule AdventElixir.Day3Test do
  use ExUnit.Case
  doctest AdventElixir.Day3, import: true

  describe "day 3" do
    setup do
      {:ok, fixture: read_input("../fixtures/day_3.txt")}
    end

    test "a", %{fixture: input} do
      assert AdventElixir.Day3.run(input) == 110827
    end

    test "b", %{fixture: input} do
      assert input
    end
  end

  defp read_input(path) do
    Path.join([__DIR__, path])
    |> File.read!()
  end
end
