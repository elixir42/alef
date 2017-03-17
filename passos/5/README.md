# Passo 5

Fazer função `main` exibir o resultado de `listar`.

Limitações desse "MVP":

* assume que o arquivo `UnicodeData.txt` está no diretório `$HOME` do usuário
* saída sem formatação, mostrando resultado "cru" de `listar`

## Debugging

### 1. Incluir chamada `IEx.pry` ➊

```elixir
def main(argv) do
  import IEx; IEx.pry  # ➊
  consulta = argv |> Enum.join(" ") |> String.upcase
  ucd = File.open!(caminho_UCD())
  IO.inspect(listar(ucd, consulta))
end
```

### 2. Invocar `iex`:

```bash
$ iex -S mix
```

### 3. Cutucar o código até achar o problema

```elixir
pry(2)> Alef.main(["A", "B"])
Request to pry #PID<0.106.0> at lib/alef.ex:53


      def main(argv) do
        import IEx; IEx.pry
        consulta = argv |> Enum.join(" ") |> String.upcase
        ucd = File.open!(caminho_UCD())

Allow? [Yn] y

Interactive Elixir (1.4.2) - press Ctrl+C to exit (type h() ENTER for help)
pry(1)> Alef.consulta_UCD()
** (UndefinedFunctionError) function Alef.consulta_UCD/0 is undefined or private
    (alef) Alef.consulta_UCD()
pry(1)> Alef.caminho_UCD()
"/Users/lramalho/UnicodeData.txt"
pry(2)> ucd = File.open!(Alef.caminho_UCD())
#PID<0.113.0>
pry(3)> Alef.listar(ucd, "REGISTERED")
** (ArgumentError) argument error
    (alef) lib/alef.ex:15: Alef.analisar_linha/1
    (alef) lib/alef.ex:40: Alef.listar_rec/3
pry(3)> linha = IO.read(ucd, :line)
"DB7F;<Non Private Use High Surrogate, Last>;Cs;0;L;;;;;N;;;;;\n"
pry(4)>
```

### 4. Criar um teste que expõe o bug

```elixir
test "analisar linha com codepoint que não é caractere" do
  surrogate = "DB7F;<Non Private Use High Surrogate, Last>;Cs;0;L;;;;;N;;;;;"
  assert {<<0xfffd::utf8>>, "<Non Private Use High Surrogate, Last>", _} =
    analisar_linha(surrogate)
  # o caractere devolvido é: U+FFFD � REPLACEMENT CHARACTER
end
```

### 5. Resolver o bug e demonstrar o MVP!

```bash
$ ./alef cat eyes
[{"😸", "GRINNING CAT FACE WITH SMILING EYES"},
 {"😻", "SMILING CAT FACE WITH HEART-SHAPED EYES"},
 {"😽", "KISSING CAT FACE WITH CLOSED EYES"}]
```
