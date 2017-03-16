defmodule Alef.Runes do
  @doc """
  analisar_linha/1
  """
  def analisar_linha(linha) do
    campos = String.split(linha, ";")
    [codigo, nome | _] = campos
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

end
