defmodule Alef do
  @moduledoc """
  Documentação de Alef.
  """

  alias Alef.Runas

  def formatar_runa({codigo, runa, nome}),
    do: "U+#{codigo}\t#{runa}\t#{nome}"

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
    |> Stream.map(&formatar_runa/1) # 3
    |> Enum.join("\n")
    |> IO.puts()
  end

end
