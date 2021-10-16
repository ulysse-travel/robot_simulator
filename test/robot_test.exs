defmodule RobotTest do
  use ExUnit.Case
  doctest Robot

  # Note: Those tests were written after the workshop.

  describe "parse" do
    test "loads fixtures" do
      expected = ["PLACE 0,0,NORTH", "MOVE", "REPORT"]
      assert Robot.parse("test/fixtures/example_a.txt") == expected
    end
  end

  describe "evaluate" do
    test "example_a" do
      expected = %Robot{direction: "NORTH", x: 0, y: 1}
      assert Robot.evaluate("example_a.txt") == expected
    end

    test "example_b" do
      expected = %Robot{direction: "WEST", x: 0, y: 0}
      assert Robot.evaluate("example_b.txt") == expected
    end

    test "example_c" do
      expected = %Robot{direction: "NORTH", x: 3, y: 3}
      assert Robot.evaluate("example_c.txt") == expected
    end
  end

  describe "apply_move" do
    test "simple expectations" do
      assert Robot.apply_move(%Robot{x: 0, y: 0, direction: "NORTH"}) == %Robot{direction: "NORTH", x: 0, y: 1}
      assert Robot.apply_move(%Robot{x: 0, y: 4, direction: "SOUTH"}) == %Robot{direction: "SOUTH", x: 0, y: 3}
      assert Robot.apply_move(%Robot{x: 2, y: 2, direction: "EAST"}) == %Robot{direction: "EAST", x: 3, y: 2}
      assert Robot.apply_move(%Robot{x: 2, y: 2, direction: "WEST"}) == %Robot{direction: "WEST", x: 1, y: 2}
    end

    test "boundaries expectations" do
      assert Robot.apply_move(%Robot{x: 0, y: 4, direction: "NORTH"}) == %Robot{direction: "NORTH", x: 0, y: 4}
      assert Robot.apply_move(%Robot{x: 0, y: 0, direction: "SOUTH"}) == %Robot{direction: "SOUTH", x: 0, y: 0}
      assert Robot.apply_move(%Robot{x: 4, y: 0, direction: "EAST"}) == %Robot{direction: "EAST", x: 4, y: 0}
      assert Robot.apply_move(%Robot{x: 0, y: 0, direction: "WEST"}) == %Robot{direction: "WEST", x: 0, y: 0}
    end
  end
end
