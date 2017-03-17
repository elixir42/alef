defmodule AlefTest do
  use ExUnit.Case
  doctest Alef

  import Alef, only: [ analisar_linha: 1, listar: 2 ]

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
    nome = "APOSTROPHE (APOSTROPHE-QUOTE)"
    palavras = MapSet.new(["APOSTROPHE", "QUOTE"])
    assert {"'", ^nome, _} = analisar_linha(apostrofe)
    assert {"'", ^nome, ^palavras} = analisar_linha(apostrofe)
  end

  @linhas_3d_a_43 """
  003D;EQUALS SIGN;Sm;0;ON;;;;;N;;;;;
  003E;GREATER-THAN SIGN;Sm;0;ON;;;;;Y;;;;;
  003F;QUESTION MARK;Po;0;ON;;;;;N;;;;;
  0040;COMMERCIAL AT;Po;0;ON;;;;;N;;;;;
  0041;LATIN CAPITAL LETTER A;Lu;0;L;;;;;N;;;;0061;
  0042;LATIN CAPITAL LETTER B;Lu;0;L;;;;;N;;;;0062;
  0043;LATIN CAPITAL LETTER C;Lu;0;L;;;;;N;;;;0063;
  """

  test "consulta uma palavra, uma linha" do
    {:ok, arq} = StringIO.open(@linhas_3d_a_43)
    assert [{"?", "QUESTION MARK"}] = listar(arq, "MARK")
  end

  test "consulta uma palavra, duas linhas" do
    {:ok, arq} = StringIO.open(@linhas_3d_a_43)
    assert [{"=", "EQUALS SIGN"}, {">", "GREATER-THAN SIGN"}] = listar(arq, "SIGN")
  end

  test "consulta duas palavras, três linhas" do
    {:ok, arq} = StringIO.open(@linhas_3d_a_43)
    assert [{"A", "LATIN CAPITAL LETTER A"},
            {"B", "LATIN CAPITAL LETTER B"},
            {"C", "LATIN CAPITAL LETTER C"}] = listar(arq, "CAPITAL LATIN")
  end


end
