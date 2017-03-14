defmodule Alef.CLI do

  @moduledoc """
  Parse command line options and call functions to produce list of Unicode
  characters matched by words in the name.
  """

  def run(argv) do
    Enum.join(argv, ", ")
    |> IO.puts
  end

end
