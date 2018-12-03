defmodule AdventElixirTest do
  use ExUnit.Case
  doctest AdventElixir, import: true

  describe "day 1" do
    setup do
      {:ok, fixture: read_input("./fixtures/day_1.txt")}
    end

    test "a", %{fixture: input} do
      assert AdventElixir.day_1a(input) == 556
    end

    test "b", %{fixture: input} do
      assert AdventElixir.day_1b(input) == 448
    end
  end

  describe "day 2" do
    setup do
      {:ok, fixture: read_input("./fixtures/day_2.txt")}
    end

    test "a", %{fixture: input} do
      assert AdventElixir.day_2a(input) == 5928
    end

    test "b", %{fixture: input} do
      assert AdventElixir.day_2b(input) == "bqlporuexkwzyabnmgjqctvfs"
    end
  end

  defp read_input(path) do
    Path.join([__DIR__, path])
    |> File.read!()
    |> String.split("\n", trim: true)
  end
end
