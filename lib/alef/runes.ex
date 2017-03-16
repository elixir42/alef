defmodule Alef.Runes do
  @doc """
  analisar_linha/1
  """
  def analisar_linha(linha) do
    campos = String.split(linha, ";")
    [code, nome | _rest] = campos
    nome_alt = Enum.at(campos, 10)
    palavras = tokenizar(nome <> " " <> nome_alt)
    nome = rune_name(nome, nome_alt)
    runa = code_to_rune(code)

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

  defp code_to_rune(code) do
    try do
      <<String.to_integer(code, 16)::utf8>>
    rescue ArgumentError -> " "
    end
  end

  defp rune_name(nome, ""), do: nome
  defp rune_name(nome, nome_alt), do: "#{nome} (#{nome_alt})"

end
