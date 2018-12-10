defmodule AdventElixir.Day4Test do
  use ExUnit.Case
  doctest AdventElixir.Day4, import: true

  describe "day 4" do
    setup do
      {:ok, fixture: read_input("../fixtures/day_4.txt")}
    end

    test "a", %{fixture: input} do
      assert true
    end

    test "b", %{fixture: input} do
      assert true
    end
  end

  defp read_input(path) do
    Path.join([__DIR__, path])
    |> File.read!()
  end
end
