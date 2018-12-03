defmodule AdventElixirTest do
  use ExUnit.Case
  doctest AdventElixir, import: true

  describe "day 1" do
    setup do
      fixture =
        Path.join([__DIR__, "./fixtures/day_1.txt"])
        |> File.read!()
        |> String.split("\n", trim: true)

      {:ok, fixture: fixture}
    end

    test "a", %{fixture: input} do
      assert AdventElixir.day_1a(input) == 556
    end

    test "b", %{fixture: input} do
      assert AdventElixir.day_1b(input) == 448
    end
  end

end
