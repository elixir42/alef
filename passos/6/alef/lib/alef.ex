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
    palavras = tokenizar("#{nome} #{nome_alt}")
    {codigo_str, nome_completo(nome, nome_alt), palavras}
  end

  defp runa_de_codigo(codigo_str) do
    codigo = String.to_integer(codigo_str, 16)
    try do
      <<codigo::utf8>>
    rescue
      ArgumentError -> <<0xfffd::utf8>>  # U+FFFD � REPLACEMENT CHARACTER
    end
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
    |> filtrar(arquivo)
  end

  defp filtrar(consulta, arquivo) do
    IO.stream(arquivo, :line)
    |> Stream.map(&analisar_linha/1)
    |> Stream.filter(fn {_, _, palavras} ->
                        MapSet.subset?(consulta, palavras)
                     end)
    |> Stream.map(fn {runa, nome,_} -> {runa, nome} end)
    |> Enum.to_list
  end

  def caminho_UCD, do: System.user_home() <> "/UnicodeData.txt"

  def formatar({codigo_str, nome}) do
    runa = runa_de_codigo(codigo_str)
    "U+#{codigo_str}\t#{runa}\t#{nome}"
  end

  def main(argv) do
    consulta = argv
               |> Enum.join(" ")
               |> String.upcase
    ucd = caminho_UCD()
          |> File.open!()
    listar(ucd, consulta)
    |> Stream.map(&formatar/1)
    |> Enum.join("\n")
    |> IO.puts()

  end

end
