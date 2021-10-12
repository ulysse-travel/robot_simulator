defmodule RobotSimulator do
  @moduledoc """
  Documentation for `RobotSimulator`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> RobotSimulator.hello()
      :world

  """
  def run(file) do
    simulator = %{x: 0, y: 0, f: "NORTH", placed: false, reported: false}
    file
    |> File.read!
    |> String.split("\n")
    |> Enum.reduce(simulator, &handle_cmd/2)
    |> print
  end

  defp print(%{x: x, y: y, f: f} = simulator) do
    "#{inspect x},#{inspect y},#{f}"
  end

  defp handle_cmd("PLACE " <> args, simulator) do
    [x, y, f] = String.split(args, ",")
    x = String.to_integer(x)
    y = String.to_integer(y)
    cond do
        x < 0 or x > 4 or y < 0 or y > 4 -> simulator
        true -> %{simulator | x: x, y: y, f: f, placed: true}
    end
  end
  defp handle_cmd(_, %{placed: false} = simulator) do
    simulator
  end
  defp handle_cmd(_, %{reported: true} = simulator) do
    simulator
  end
  defp handle_cmd(_, %{x: x, y: y} = simulator) when x < 0 or x > 4 or y < 0 or y > 4 do
    simulator
  end
  defp handle_cmd("MOVE", %{x: x, y: y, f: f} = simulator) do
    case f do
        "NORTH" when y < 4 -> %{simulator | y: y+1}
        "WEST" when x > 0 -> %{simulator | x: x-1}
        "SOUTH" when y > 0 -> %{simulator | y: y-1}
        "EAST" when x < 4 -> %{simulator | x: x+1}
        _ -> simulator
    end
  end
  defp handle_cmd("REPORT", simulator) do
    %{simulator | reported: true}
  end
  defp handle_cmd("LEFT", %{f: f} = simulator) do
    case f do
        "NORTH" -> %{simulator | f: "WEST"}
        "SOUTH" -> %{simulator | f: "EAST"}
        "EAST" -> %{simulator | f: "NORTH"}
        "WEST" -> %{simulator | f: "SOUTH"}
    end
  end
  defp handle_cmd("RIGHT", %{f: f} = simulator) do
    case f do
        "NORTH" -> %{simulator | f: "EAST"}
        "SOUTH" -> %{simulator | f: "WEST"}
        "EAST" -> %{simulator | f: "SOUTH"}
        "WEST" -> %{simulator | f: "NORTH"}
    end
  end
  defp handle_cmd(_, simulator) do
    simulator
  end
end
