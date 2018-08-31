# Passo 3

Criar testes para `listar` e implementar as funcionalidades necessárias:

* Consulta de uma palavra, devolvendo uma linha
* Consulta de uma palavra, devolvendo duas linhas
* Consulta de duas palavras, devolvendo três linhas

## Dica

Para ver as descrições dos testes passando:

```bash
$ mix test --trace

AlefTest
  * test analisar linha de UnicodeData.txt com hífen (3.0ms)
  * test analisar linha simples de UnicodeData.txt (0.05ms)
  * test analisar linha de UnicodeData.txt com hífen e campo 10 (0.06ms)
  * test consulta duas palavras, três linhas (3.3ms)
  * test consulta uma palavra, duas linhas (0.2ms)
  * test consulta uma palavra, uma linha (0.1ms)


Finished in 0.09 seconds
6 tests, 0 failures

Randomized with seed 791882
```

Note que a ordem de execução dos testes não é previsível e provavelmente vai mudar a cada sessão de `mix test`.
