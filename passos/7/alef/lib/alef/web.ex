defmodule Alef.Web do
  use Tesla

  plug Tesla.Middleware.BaseUrl, "http://www.unicode.org"
  plug Tesla.Middleware.Headers, %{"User-agent" => "Elixir lab0@ramalho.org"}

  adapter Tesla.Adapter.Ibrowse

  def baixar() do
    get("/Public/UNIDATA/UnicodeData.txt")
  end
end
