# Alef

Utilitário de linha de comanto para encontrar caracteres Unicode pelo nome.

Porque _alef_: _elixir_ é uma palavra de origem árabe, e a primeira letra do alfabeto árabe é ا (alef)


## Como usar

Fara usar `alef`, forneça uma ou mais palavras como argumentos na linha de comando:

```bash
$ ./alef chess queen
U+2655	♕	WHITE CHESS QUEEN
U+265B	♛	BLACK CHESS QUEEN
$ ./alef cat eyes
U+1F638	😸	GRINNING CAT FACE WITH SMILING EYES
U+1F63B	😻	SMILING CAT FACE WITH HEART-SHAPED EYES
U+1F63D	😽	KISSING CAT FACE WITH CLOSED EYES
```

__Nota__: `alef` precisa de uma cópia de [`UnicodeData.txt`](http://www.unicode.org/Public/UNIDATA/UnicodeData.txt). Somente no [passo 7](https://github.com/ramalho/alef/tree/master/passos/7) do dojo implementamos o download. Entre os passos 5 e 6 o programa precisa encontrar arquivo [`UnicodeData.txt`](http://www.unicode.org/Public/UNIDATA/UnicodeData.txt) no diretório `$HOME` do usuário.


## Rodar testes

Para executar os testes, execute no diretório do projeto (onde fica o arquitvo `alef/mix.exs`):

```bash
$ mix test
Compiling 1 file (.ex)
Generated alef app
......

Finished in 0.06 seconds
6 tests, 0 failures

Randomized with seed 325308
```


## Gerar executável

Para construir o executável `alef`, execute no diretório do projeto:

```bash
$ mix escript.build
Compiling 1 file (.ex)
Generated alef app
Generated escript alef with MIX_ENV=dev
$ ls -lah alef
-rwxr-xr-x  1 lramalho  staff   2.7M Mar 15 14:29 alef
```

__Nota__: o executável `alef` depende do programa `escript` que vem com a distribuição Erlang.
