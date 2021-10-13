defmodule UlysseRobotTest do
  use ExUnit.Case
  doctest UlysseRobot

  test "greets the world" do
    assert UlysseRobot.hello() == :world
  end

  test "1" do
    data = """
    PLACE 0,0,NORTH
    MOVE
    REPORT
    """

    assert UlysseRobot.run(data) === "0,1,NORTH"
  end

  test "2" do
    data = """
    PLACE 0,0,NORTH
    LEFT
    REPORT
    """

    assert UlysseRobot.run(data) === "0,0,WEST"
  end

  test "3" do
    data = """
    PLACE 1,2,EAST
    MOVE
    MOVE
    LEFT
    MOVE
    REPORT
    """

    assert UlysseRobot.run(data) === "3,3,NORTH"
  end
end
