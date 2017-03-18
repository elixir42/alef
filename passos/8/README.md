# Passo 7

Fazer o download de `UnicodeData.txt` caso ele não esteja no local configurado.

## Instalar componentes

### Tesla etc.

Para o código cliente HTTP no módulo `Alef.Web` usamos pacote `Tesla`, que depende de `ibrowse`, então é preciso acrescentar linhas no `mix.exs`, função `deps`:

```elixir
defp deps do
    [{:tesla, "~> 0.6.0"},
     {:ibrowse, "~> 4.2"}]
end
```

Também é preciso registrar o `ibrowse` na função `application`:


```elixir
def application do
  # Specify extra applications you'll use from Erlang/Elixir
  [extra_applications: [:logger, :ibrowse]]
end
```

Na próxima tentativa de rodar os testes, Elixir vai pedir para instalar o gerenciador de pacotes `hex`:

```bash
$ mix test
Could not find Hex, which is needed to build dependency :tesla
Shall I install Hex? (if running non-interactively, use: "mix local.hex --force") [Yn]
```

Respondendo `Y` acontece o seguinte:

```bash
* creating /Users/luciano/.mix/archives/hex-0.15.0
Unchecked dependencies for environment test:
* tesla (Hex package)
  the dependency is not available, run "mix deps.get"
* ibrowse (Hex package)
  the dependency is not available, run "mix deps.get"
** (Mix) Can't continue due to errors on dependencies
```

É só fazer como mandam:

```bash
$ mix deps.get
Running dependency resolution...
Dependency resolution completed:
  ibrowse 4.4.0
  tesla 0.6.0
* Getting tesla (Hex package)
  Checking package (https://repo.hex.pm/tarballs/tesla-0.6.0.tar)
  Fetched package
* Getting ibrowse (Hex package)
  Checking package (https://repo.hex.pm/tarballs/ibrowse-4.4.0.tar)
  Fetched package
```

Depois que registrei `:ibrowse` em `application`, ao rodar `mix escript.build` Elixir pediu para instalar `rebar3`, e eu respondi `Y`. Neste ponto todos testes passam e é possível fazer o build do `escript` sem erro.
