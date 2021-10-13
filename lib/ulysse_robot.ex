defmodule UlysseRobot do
  @moduledoc """
  Documentation for `UlysseRobot`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> UlysseRobot.hello()
      :world

  """
  def hello do
    :world
  end

  def run(str) do
    str
    |> String.split("\n")
    |> Enum.reduce(nil, fn x, acc ->
      action(x, acc)
    end)
  end

  def orientation(), do: ["NORTH", "EAST", "SOUTH", "WEST"]

  def change_orientation(direction, {x, y, orr}) do
    index =
      orientation()
      |> Enum.find_index(fn x -> x === orr end)
      |> update_index(direction)

    new_orr = orientation() |> Enum.at(index)
    {x, y, new_orr}
  end

  def update_index(index, "LEFT"), do: index - 1
  def update_index(index, "RIGHT"), do: index + 1

  def action("PLACE " <> value, _) do
    [x, y, orientation] = value |> String.split(",")
    {x, _} = Integer.parse(x)
    {y, _} = Integer.parse(y)
    {x, y, orientation}
  end

  def action("LEFT", state), do: change_orientation("LEFT", state)
  def action("RIGHT", state), do: change_orientation("RIGHT", state)

  def action("MOVE", {5, _, "EAST"} = state), do: state
  def action("MOVE", {0, _, "WEST"} = state), do: state
  def action("MOVE", {_, 5, "NORTH"} = state), do: state
  def action("MOVE", {_, 0, "SOUTH"} = state), do: state

  def action("MOVE", {x, y, orr}) do
    case orr do
      "WEST" -> {x - 1, y, orr}
      "NORTH" -> {x, y + 1, orr}
      "SOUTH" -> {x, y - 1, orr}
      "EAST" -> {x + 1, y, orr}
    end
  end

  def action("REPORT", {x, y, orr}) do
    "#{x},#{y},#{orr}"
  end

  def action(_, state), do: state
end
