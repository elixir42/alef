defmodule Alef do
  @moduledoc """
  Documentation for Alef.
  """

  @doc """
  analisar_linha/1
  """
  def analisar_linha(linha) do
    campos = String.split(linha, ";")
    [codigo, nome] = Enum.slice(campos, 0..1)
    palavras = nome <> " " <> Enum.at(campos, 10)
            |> String.replace("-", " ")
            |> String.split
            |> MapSet.new
    runa = <<String.to_integer(codigo, 16)::utf8>>
    {runa, nome, palavras}
  end
end
