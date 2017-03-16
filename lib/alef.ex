defmodule Alef do
  @moduledoc """
  Documentation for Alef.
  """

  alias Alef.Runes

  def format_rune({rune, name}) do
    <<utf_code::utf8>> = rune

    code =
      utf_code
      |> Integer.to_string(16)
      |> String.rjust(4, ?0)
    "U+#{code}\t#{rune}\t#{name}"
  end

  @doc """
  Steps to be taken:

  0) Parse in params
  1) Get the file to read (FileHandler is responsible for checking that and getting a new one if necessary)
  2) Send all to a parser, so it can parse an find found data
  3) Displays it
  """
  def main(argv) do
    args = Enum.join(argv, " ") |> String.upcase() # 0
    file = Alef.FileHandler.read() # 1

    Runes.listar(file, args) # 2
    |> Stream.map(&format_rune/1) # 3
    |> Enum.join("\n")
    |> IO.puts()
  end

end
