defmodule AlefTest do
  use ExUnit.Case
  doctest Alef

  import Alef, only: [ analisar_linha: 1,]

  test "analisar linha simples de UnicodeData.txt" do
    letra_A = "0041;LATIN CAPITAL LETTER A;Lu;0;L;;;;;N;;;;0061;"
    palavras = MapSet.new(["A", "CAPITAL", "LATIN", "LETTER"])
    assert {"A", "LATIN CAPITAL LETTER A", ^palavras} = analisar_linha(letra_A)
  end
    
end
