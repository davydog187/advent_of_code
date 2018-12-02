defmodule AdventElixirTest do
  use ExUnit.Case
  doctest AdventElixir

  test "greets the world" do
    assert AdventElixir.hello() == :world
  end
end
