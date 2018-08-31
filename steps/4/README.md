# Passo 4

Criar função `main` e fazê-la exibir os argumentos da linha de comando convertidos em caixa alta.

## Instruções

Um programa executável pela linha de comando em Elixir depende do programa [`enscript`](http://erlang.org/doc/man/escript.html) que vem na distribuição padrão de Erlang. O `enscript` executa um binário compilado de BEAM (a VM de Erlang).

Para o binário de `enscript` ser gerado corretamente, é preciso incluir uma linha no arquivo `mix.exs` na raiz do seu projeto (`alef/`). Veja o comentário marcado com ➊:

```elixir
defmodule Alef.Mixfile do
  use Mix.Project

  def project do
    [app: :alef,
     version: "0.1.0",
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     escript: [main_module: Alef], # ➊ declara módulo principal
     deps: deps()]
  end

  # mais linhas omitidas...
end
```

Em seguida, você compila o projeto e gera o executável com este comando:


```bash
$ mix escript.build
```

Será gerado um executável com o nome do projeto, `alef`, que você pode rodar:

```bash
$ ./alef um dois três
UM DOIS TRÊS
```
