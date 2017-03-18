# Passo 6

Formatar a saída da função `main`.

## Uma falha de design

Implementei este teste para a formatação de cada linha de resultado que será exibida por `main`:

```elixir
  test "formatar resultado simples" do
    assert "U+0041\tA\tLATIN CAPITAL LETTER A" =
      formatar({"A", "LATIN CAPITAL LETTER A"})
  end

```

Com base neste teste, implementei a função `formatar` assim, satisfazendo o teste:

```elixir
def formatar({runa, nome}) do
  <<codigo::utf8>> = runa
  codigo_fmt = codigo
            |> Integer.to_string(16)
            |> String.rjust(4, ?0)
  "U+#{codigo_fmt}\t#{runa}\t#{nome}"
end
```

No entanto, ao criar um teste de formatação para os gremlins (um gremlin é um caractere inválido), descobri um erro cometido lá no passo 1. Veja o teste e o erro:

```elixir
test "formatar resultado que não é caractere" do
  assert "U+DB7F\t�\t<Non Private Use High Surrogate, Last>" =
    formatar({<<0xFFFD::utf8>>, "<Non Private Use High Surrogate, Last>"})
end
```

```bash
$ mix test
........

  1) test formatar resultado que não é caractere (AlefTest)
     test/alef_test.exs:66
     match (=) failed
     code:  "U+DB7F\t�\t<Non Private Use High Surrogate, Last>" = formatar({<<65533::utf8>>, "<Non Private Use High Surrogate, Last>"})
     right: "U+FFFD\t�\t<Non Private Use High Surrogate, Last>"
     stacktrace:
       test/alef_test.exs:67: (test)



Finished in 0.1 seconds
9 tests, 1 failure

Randomized with seed 287163
```

Na realidade, o teste está errado! O resultado correto é o que está lá na primeira linha do `assert`:

```elixir
"U+DB7F\t�\t<Non Private Use High Surrogate, Last>"
```

Mas para obter esse resultado eu não posso invocar `formatar` com o binário `<<0xFFFD::utf8>>` e sim com `<<0xDB7F::utf8>>`, porém esse binário é inválido, porque `0xDB7F` não é um caractere, portanto não tem representação em UTF-8. O código Unicode U+DB7F é um "surrogate" (substituto), que só pode ser usado como prefixo em uma sequência de códigos, para representar caracteres fora do conjunto Unicode.

O problema foi um erro de projeto que aconteceu lá no passo 1: a função `analisar_linha` não pode retornar um caractere e um nome, e sim um código hexadecimal e um nome. Apenas no último momento antes de exibir esse código hexadecimal deve ser transformado em um caractere, e caso não seja um caractere válido, o caractere U+FFFD (�) deve ser exibido em seu lugar.

Então para completar o passo 6 é preciso mudar todos os testes. Mas a implementação fica até mais simples do que antes:

* `analisar_linha`: apagar uma linha e alterar outra
* `formatar`: apagar três linhas e alterar outras três
