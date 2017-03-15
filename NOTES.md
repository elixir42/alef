# Notes while developing this example

To manually test the `CLI.run` function:

```bash
​​$ ​​mix run -e 'Alef.CLI.run(["cat", "face"])'
```

What would be the simplest way of running the app at this point, when all the code I added is in Alef.CLI.run?

To build a standalone program:

```bash
$ mix escript.build
```
