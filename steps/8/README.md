# Passo 8

Fazer o download em modo assíncrono, exibindo pontos na tela para indicar que o programa não travou.

Usamos `Task.async` para disparar o download e `Task.yield` para esperar o resultado exibindo pontos enquanto a tarefa não termina.
