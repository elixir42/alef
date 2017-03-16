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
    nome_alt = Enum.at(campos, 10)
    palavras = tokenizar(nome <> " " <> nome_alt)
    nome = if nome_alt == "", do: nome, else: "#{nome} (#{nome_alt})"
    runa = try do
             <<String.to_integer(codigo, 16)::utf8>>
           rescue
             ArgumentError -> " "
           end
    {runa, nome, palavras}
  end

  def tokenizar(texto) do
    texto
    |> String.replace("-", " ")
    |> String.split
    |> MapSet.new
  end

  def listar(arq, consulta) do
    consulta = tokenizar(consulta)
    listar_rec(arq, consulta, [])
  end

  defp listar_rec(arq, consulta, resultados) do
    linha = IO.read(arq, :line)
    #IO.puts(">" <> linha)
    if (linha == :eof) do
      Enum.reverse(resultados)
    else
      {runa, nome, palavras} = analisar_linha(linha)
      if MapSet.subset?(consulta, palavras) do
        listar_rec(arq, consulta, [{runa, nome}|resultados])
      else
        listar_rec(arq, consulta, resultados)
      end
    end
  end

  def formatar(runa_nome) do
    {runa, nome} = runa_nome
    <<codigo::utf8>> = runa
    codigo = codigo
          |> Integer.to_string(16)
          |> String.rjust(4, ?0)
    "U+#{codigo}\t#{runa}\t#{nome}"
  end

  def abrir_UCD(caminho) do
    case File.open(caminho) do
      {:ok, arq} -> arq
      {:error, :enoent} -> Alef.Cliente.get(caminho)
                        |> StringIO.open
                        |> elem(1)
    end
  end

  def main(argv) do
    caminho = System.user_home() <> "/UnicodeData.txt"
    arq = abrir_UCD(caminho)
    consulta = Enum.join(argv, " ") |> String.upcase
    listar(arq, consulta)
    |> Stream.map(&formatar/1)
    |> Enum.join("\n")
    |> IO.puts
  end

end
