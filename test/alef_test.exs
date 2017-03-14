defmodule AlefTest do
  use ExUnit.Case
  doctest Alef

  import Alef, only: [ analisar_linha: 1 ]

  test "analisar linha simples de UnicodeData.txt" do
    letra_A = "0041;LATIN CAPITAL LETTER A;Lu;0;L;;;;;N;;;;0061;"
    palavras = MapSet.new(["A", "CAPITAL", "LATIN", "LETTER"])
    assert {"A", "LATIN CAPITAL LETTER A", ^palavras} = analisar_linha(letra_A)
  end

  test "analisar linha de UnicodeData.txt com hífen" do
    hifen = "002D;HYPHEN-MINUS;Pd;0;ES;;;;;N;;;;;"
    palavras = MapSet.new(["HYPHEN", "MINUS"])
    assert {"-", "HYPHEN-MINUS", ^palavras} = analisar_linha(hifen)
  end

  test "analisar linha de UnicodeData.txt com hífen e campo 10" do
    apostrofe = "0027;APOSTROPHE;Po;0;ON;;;;;N;APOSTROPHE-QUOTE;;;"
    palavras = MapSet.new(["APOSTROPHE", "QUOTE"])
    assert {"'", "APOSTROPHE", ^palavras} = analisar_linha(apostrofe)
  end


end
