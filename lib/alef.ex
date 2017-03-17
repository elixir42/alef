defmodule Alef do
  @moduledoc """
  Documentação de Alef.
  """

  alias Alef.Runas

  def format_rune({rune, name}) do
    <<utf_code::utf8>> = rune

    code =
      utf_code
      |> Integer.to_string(16)
      |> String.rjust(4, ?0)
    "U+#{code}\t#{rune}\t#{name}"
  end

  @doc """
  Passos:

  0) Analisar argumentos da linha de comando
  1) Ler o arquivo UCD (Arquivo cuida de encontrar ou baixar se necessário)
  2) Envia UCD e consulta para função que monta a lista de resultados
  3) Formata e exibe os resultados
  """
  def main(argv) do
    consulta = Enum.join(argv, " ") |> String.upcase() # 0
    ucd = Alef.Arquivo.ler() # 1

    Runas.listar(ucd, consulta) # 2
    |> Stream.map(&format_rune/1) # 3
    |> Enum.join("\n")
    |> IO.puts()
  end

end
