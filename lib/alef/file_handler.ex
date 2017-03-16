require Logger

defmodule Alef.FileHandler do
  def caminho_UCD do
    System.user_home() <> "/UnicodeData.txt"
  end

  def read do
    unless existe_UCD?() do
      # @JL: use debug, so it will only print on dev env
      # this way the programs follows Unix Philosophy
      Logger.debug("No unicode_data found, downloading...")

      %{body: dados} = Alef.Unicode.data()

      Logger.debug("Download finished\n")

      caminho_UCD()
      |> save_file(dados)
    end

    caminho_UCD()
    |> File.open!()
  end

  def existe_UCD? do
    caminho_UCD()
    |> File.exists?()
  end

  def save_file(caminho, dados) do
    with {:ok, file} <- File.open(caminho, [:write]) do
      file |> IO.binwrite(dados)
      file |> File.close()
    else
      _ -> exit(:file_err)
    end
  end
end
