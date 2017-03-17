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

## Apparent Inconsistencies

### Invoking anonymous functions

Why the dot in `my_fun.()`?

### One liners with `do`

Suddenly a comma and a colon are required...


### Restrictions on guards?

Why so many restrictions on operators and functions that may be used on `when` clauses?


### Naming functions in `import`

Why does `import` identify functions `[ myfunc: 1,]` when elsewhere we name them `myfunc/1` (for example, when invoking `Enum.map`)