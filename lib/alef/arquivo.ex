require Logger

defmodule Alef.Arquivo do
  def caminho_UCD do
    System.user_home() <> "/UnicodeData.txt"
  end

  def ler do
    unless existe_UCD?() do
      # @JL: use debug, so it will only print on dev env
      # this way the programs follows Unix Philosophy
      Logger.debug("#{caminho_UCD()} não encontrado, baixando...")

      %{body: dados} = Alef.Unicode.baixar()

      Logger.debug("Download concluído.")

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
