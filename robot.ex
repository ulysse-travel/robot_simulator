defmodule Robot do
  defstruct [:x, :y, :direction]

  def parse(filepath) do
    {:ok, content} = File.read(filepath)
    content
    |> String.split("\n")
  end

  def evaluate(filename) do
    IO.puts "Evaluating #{filename}"

    parse("#{filename}")
    |> Enum.reject(fn x -> x == "" end)
    |> Enum.reduce(%Robot{}, fn statement, acc ->
      command(statement, acc)
    end)
  end

  def command("REPORT", acc) do
    IO.inspect acc
    acc
  end

  def command("MOVE", acc) do
    apply_move(acc)
  end

  def command("LEFT", %Robot{direction: direction} = acc) do
    case direction do
      "NORTH" -> %{acc | direction: "WEST"}
      "SOUTH" -> %{acc | direction: "EAST"}
      "WEST" -> %{acc | direction: "SOUTH"}
      "EAST" -> %{acc | direction: "NORTH"}
    end
  end

  def command("RIGHT", %Robot{direction: direction} = acc) do
    case direction do
      "NORTH" -> %{acc | direction: "EAST"}
      "SOUTH" -> %{acc | direction: "WEST"}
      "WEST" -> %{acc | direction: "NORTH"}
      "EAST" -> %{acc | direction: "SOUTH"}
    end
  end

  # PLACE statement
  def command(statement, acc) do
    [command, args] =
      statement
      |> String.split(" ")

    [x, y, direction] =
      args |> String.split(",")

    %{acc | x: x |> String.to_integer(), y: y |> String.to_integer(), direction: direction}
  end



  def apply_move(%Robot{y: y, direction: "NORTH"} = acc) when is_integer(y) and y < 5 do
    %Robot{acc | y: y + 1}
  end
  def apply_move(%Robot{y: y, direction: "NORTH"} = acc) do
    %Robot{acc | y: y}
  end

  def apply_move(%Robot{y: y, direction: "SOUTH"} = acc) when is_integer(y) and y > 0 do
    %Robot{acc | y: y - 1}
  end
  def apply_move(%Robot{y: y, direction: "SOUTH"} = acc) do
    %Robot{acc | y: y}
  end

  def apply_move(%Robot{x: x, direction: "WEST"} = acc) when is_integer(x) and x > 0 do
    %Robot{acc | x: x - 1}
  end
  def apply_move(%Robot{x: x, direction: "WEST"} = acc) do
    %Robot{acc | x: x}
  end

  def apply_move(%Robot{x: x, direction: "EAST"} = acc) when is_integer(x) and x < 5 do
    %Robot{acc | x: x + 1}
  end
  def apply_move(%Robot{x: x, direction: "EAST"} = acc) do
    %Robot{acc | x: x}
  end
end

Robot.evaluate("example_a.txt")
Robot.evaluate("example_b.txt")
Robot.evaluate("example_c.txt")
