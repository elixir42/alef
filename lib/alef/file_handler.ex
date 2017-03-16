require Logger

defmodule Alef.FileHandler do
  def file_path do
    System.user_home() <> "/UnicodeData.txt"
  end

  def read do
    unless unicode_data_exists?() do
      # use debug, so it will only print on dev env
      # this way the programs follows Unix Philosophy
      Logger.debug("No unicode_data found, downloading...")

      %{body: data} = Alef.Unicode.data()

      Logger.debug("Download finished\n")

      file_path()
      |> save_file(data)
    end

    file_path()
    |> File.open!()
  end

  def unicode_data_exists? do
    file_path()
    |> File.exists?()
  end

  def save_file(path, data) do
    with {:ok, file} <- File.open(path, [:write]) do
      file |> IO.binwrite(data)
      file |> File.close()
    else
      _ -> exit(:file_err)
    end
  end
end
