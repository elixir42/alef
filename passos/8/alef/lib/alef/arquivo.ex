defmodule Alef.Arquivo do

  def caminho_UCD do
    System.user_home() <> "/UnicodeData.txt"
  end

  def ler do
    unless existe_UCD?() do
      IO.puts("#{caminho_UCD()} não encontrado\nbaixando #{Alef.Web.url_ucd()}")
      %{body: dados} = Alef.Web.baixar()
      caminho_UCD()
      |> salvar(dados)
    end

    caminho_UCD()
    |> File.open!()
  end

  def existe_UCD? do
    caminho_UCD()
    |> File.exists?()
  end

  def salvar(caminho, dados) do
    with {:ok, arq} <- File.open(caminho, [:write]) do
      arq |> IO.binwrite(dados)
      arq |> File.close()
    else
      _ -> exit(:file_err)
    end
  end
end
