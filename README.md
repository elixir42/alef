# Alef

Elixir CLI utility to find Unicode Characters.

Elixir is an arabic word, and alef is the name of the first arabic letter.

## Testing and building

To run the tests:

```bash
$ mix test
Compiling 1 file (.ex)
Generated alef app
......

Finished in 0.06 seconds
6 tests, 0 failures

Randomized with seed 325308
```

To build the `alef` executable:

```bash
$ mix escript.build
Compiling 1 file (.ex)
Generated alef app
Generated escript alef with MIX_ENV=dev
$ ls -lah alef
-rwxr-xr-x  1 lramalho  staff   2.7M Mar 15 14:29 alef
```

__Note__: the `alef` binary depends on the `escript` program that comes with the Erlang distribution.


## Using

`alef` lets you find Unicode characters by name. To use, provide one or more words as command-line arguments:

```bash
$ ./alef chess queen
U+2655	♕	WHITE CHESS QUEEN
U+265B	♛	BLACK CHESS QUEEN
$ ./alef cat eyes
U+1F638	😸	GRINNING CAT FACE WITH SMILING EYES
U+1F63B	😻	SMILING CAT FACE WITH HEART-SHAPED EYES
U+1F63D	😽	KISSING CAT FACE WITH CLOSED EYES
```

__Note__: `alef` needs a copy of the `UnicodeData.txt` file which you need to download from [unicode.org](http://www.unicode.org/Public/UNIDATA/UnicodeData.txt) and save in your home directory. The next version of `alef` will do that automatically, but this MVP doesn't.
