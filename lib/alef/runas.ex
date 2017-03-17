defmodule Alef.Runas do
  @doc """
  analisar_linha/1
  """
  def analisar_linha(linha) do
    campos = String.split(linha, ";")
    [codigo, nome | _rest] = campos
    nome_alt = Enum.at(campos, 10)
    palavras = tokenizar(nome <> " " <> nome_alt)
    nome = nome_completo(nome, nome_alt)
    runa = runa_de_codigo(codigo)

    {runa, nome, palavras}
  end

  def tokenizar(texto) do
    texto
    |> String.replace("-", " ")
    |> String.split
    |> MapSet.new
  end

  defp runa_de_codigo(codigo) do
    try do
      <<String.to_integer(codigo, 16)::utf8>>
    rescue ArgumentError -> " "
    end
  end

  defp nome_completo(nome, ""), do: nome
  defp nome_completo(nome, nome_alt), do: "#{nome} (#{nome_alt})"

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
