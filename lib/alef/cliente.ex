defmodule Alef.Cliente do
  @user_agent [ {"User-agent", "Elixir lab0@ramalho.org"} ]
  @ucd_url "http://www.unicode.org/Public/UNIDATA/UnicodeData.txt"

  def get(caminho) do
    IO.puts("#{caminho} não encontrado\nbaixando #{@ucd_url}...")
    %{body: body} = Alef.Unicode.data()
    save_file(caminho, body)
  end

  def save_file(path, data) do
    IO.puts "saving file"
    file = File.open!(path, [:write])
    IO.binwrite(file, data)
    File.close(file)
  end

end
