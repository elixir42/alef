defmodule Alef.Web do
  use Tesla

  @ucd_url "http://www.unicode.org/Public/UNIDATA/UnicodeData.txt"

  adapter Tesla.Adapter.Ibrowse

  def baixar() do
    get(@ucd_url)
  end
end
