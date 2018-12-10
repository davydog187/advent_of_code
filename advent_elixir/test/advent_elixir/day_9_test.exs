defmodule AdventElixir.Day9Test do
  use ExUnit.Case
  doctest AdventElixir.Day9, import: true

  describe "day 9" do
    test "a" do
      assert AdventElixir.Day9.marbles(10, 1618) == 8317
      assert AdventElixir.Day9.marbles(13, 7999) == 146373
      assert AdventElixir.Day9.marbles(17, 1104) == 2764
      assert AdventElixir.Day9.marbles(21, 6111) == 54718
      assert AdventElixir.Day9.marbles(30, 5807) == 37305
    end

    test "a answer" do
      #assert AdventElixir.Day9.marbles(428, 72061) == 409832
    end

    test "b" do
      assert AdventElixir.Day9.marbles(428, 72061 * 100) == 409832
    end
  end
end
