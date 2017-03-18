defmodule Alef.Web do
  use Tesla

  adapter Tesla.Adapter.Ibrowse

  @espera_total 30_000  # espera pelo download, em ms
  @intervalo 150   # intervalo entre indicações de progresso, em ms

  def url_ucd() do
    "http://www.unicode.org/Public/UNIDATA/UnicodeData.txt"
  end

  def baixar() do
    tarefa = Task.async(fn -> get(url_ucd()) end)
    progresso(tarefa, @espera_total)
  end

  def progresso(tarefa, espera) do
    if espera <= 0 do
      IO.puts("\nERRO: timeout")
      nil
    else
      case Task.yield(tarefa, @intervalo) do
        {:ok, resultado} ->
          IO.write("\n")
          resultado
        nil ->
          IO.write(".")
          progresso(tarefa, espera-@intervalo)
      end
    end
  end

end
