defmodule Alef do
  @moduledoc """
  Documentation for Alef.
  """

  @doc """
  Extrair campos de uma linha de `UncicodeData.txt`
  """

  def analisar_linha(linha) do
    campos = String.split(linha, ";")
    [codigo_str, nome | _rest] = campos
    palavras = String.split(nome)
            |> MapSet.new
    runa = <<String.to_integer(codigo_str, 16)::utf8>>
    {runa, nome, palavras}
  end
end
