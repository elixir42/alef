defmodule Alef.Cliente do
  @user_agent [ {"User-agent", "Elixir lab0@ramalho.org"} ]
  @ucd_url "http://www.unicode.org/Public/UNIDATA/UnicodeData.txt"

  def get(caminho) do
    IO.puts("#{caminho} não encontrado\nbaixando #{@ucd_url}...")
    HTTPoison.get(@ucd_url, @user_agent)
    |> handle_response(caminho)
  end

  def handle_response({ :ok, %{status_code: 200, body: body}}, caminho) do
    arq = File.open!(caminho, [:write])
    IO.binwrite(arq, body)
    File.close(arq)
    IO.puts("feito.")
    body
  end

  def handle_response({ _,   %{status_code: _,   body: body}}, _) do
    { :error, body }
  end
end
