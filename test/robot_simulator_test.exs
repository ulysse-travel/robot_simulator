defmodule RobotSimulatorTest do
  use ExUnit.Case

  test "example a" do
    file = "test/example_a.txt"
    assert RobotSimulator.run(file) == "0,1,NORTH"
  end
  test "example b" do
    file = "test/example_b.txt"
    assert RobotSimulator.run(file) == "0,0,WEST"
  end
  test "example c" do
    file = "test/example_c.txt"
    assert RobotSimulator.run(file) == "3,3,NORTH"
  end
  test "example d" do
    file = "test/example_d.txt"
    assert RobotSimulator.run(file) == "0,0,WEST"
  end
end
