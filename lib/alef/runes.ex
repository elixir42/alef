defmodule Alef.Runes do
  @doc """
  analisar_linha/1
  """
  def analisar_linha(linha) do
    fields = String.split(linha, ";")
    [code, name | _rest] = fields
    alt_name = Enum.at(fields, 10)

    name = rune_name(name, alt_name)
    palavras = tokenizar(name <> " " <> alt_name)
    runa = code_to_rune(code)

    {runa, name, palavras}
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
      {runa, name, palavras} = analisar_linha(linha)

      if MapSet.subset?(consulta, palavras) do
        listar_rec(arq, consulta, [{runa, name}|resultados])
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

  defp rune_name(name, ""), do: name
  defp rune_name(name, alt_name), do: "#{name} (#{alt_name})"

end
