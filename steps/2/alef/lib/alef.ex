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
    nome_alt = Enum.at(campos, 10)
    palavras = "#{nome} #{nome_alt}"
            |> String.replace("-", " ")
            |> String.split()
            |> MapSet.new
    runa = <<String.to_integer(codigo_str, 16)::utf8>>
    {runa, nome_completo(nome, nome_alt), palavras}
  end

  defp nome_completo(nome, ""), do: nome
  defp nome_completo(nome, nome_alt), do: "#{nome} (#{nome_alt})"

end
