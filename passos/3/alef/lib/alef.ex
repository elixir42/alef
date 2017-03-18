defmodule Alef do
  @moduledoc """
  Documentation for Alef.
  """

  @doc """
  Extrair campos de uma linha de `UnicodeData.txt`
  """

  def analisar_linha(linha) do
    campos = String.split(linha, ";")
    [codigo_str, nome | _rest] = campos
    nome_alt = Enum.at(campos, 10)
    palavras = tokenizar("#{nome} #{nome_alt}")
    runa = <<String.to_integer(codigo_str, 16)::utf8>>
    {runa, nome_completo(nome, nome_alt), palavras}
  end

  def tokenizar(texto) do
    texto
    |> String.replace("-", " ")
    |> String.split
    |> MapSet.new
  end

  defp nome_completo(nome, ""), do: nome
  defp nome_completo(nome, nome_alt), do: "#{nome} (#{nome_alt})"

  def listar(arquivo, consulta_str) do
    consulta_str
    |> tokenizar
    |> listar_rec(arquivo)
  end

  defp listar_rec(consulta, arquivo) do
    IO.stream(arquivo, :line)
    |> Stream.map(&analisar_linha/1)
    |> Stream.filter(fn {_,_,palavras} ->
      MapSet.subset?(consulta, palavras)
    end)
    |> Stream.map(fn {runa, nome,_} -> {runa, nome} end)
    |> Enum.to_list
  end

end
