
# Cook

## A bash replacement for make

Cook is supposed to be a simple build tool. As simple as possible. Cook is just a bash script sitting on your path waiting to cook you some delicious software. When you run cook, it searches the current working directory for a file called cookbook. If the cookbook file is found, cook executes the cookbook. If cook can't find the cookbook, it returns an error. You can also tell cook which cookbook to read, with the `-f <cookbook>` option. Or get a brand new free cookbook template with the `-n <language>` option, which makes cook look for a template cookbook on the configuration directory, "~/.config/cook" by default.

Before executing your cookbook, cook makes available to your cookbook two bash functions, **contains** and **check**.

    contains <word> $@

Contains takes two arguments, **word** and $@. $@ is the list of arguments that cook was called with. Contains returns true, 0 in bash, if cook was called with that word as an argument. Here's an example of how it is supposed to be used:

    contains gcc && CC=gcc

Which reads, if cook was called with the argument "gcc", let the variable CC be gcc.

The other function is check. It takes at least two arguments. The first is the name of the file to be compiled with the other arguments. Example:

    check bin a.c b.c c.c

check returns true if the file bin don't exist or if it is older than any of the other files. check also sets a variable called DEPS, for dependencies, to be used in your compilation command. Therefore check is supposed to be used on your cookbooks like this:

    check bin a.c b.c c.c \
      && $CC -o bin $DEPS

Cook covers these make cababilities:

 - Build and install a package without
   knowing the details of how that is done.

 - Figure out automatically which files it
   needs to update, based on which source files
   have changed.

 - PLUS: You can use your favorite indentaion style.

TODO list:

 - figure out the order of dependencies.

 - implement the "-o file" make capability,
   which pretends that the file has changed, even though
   it has changed. This is useful when you
   add a new macro to a header file.

 - Run checks in parallel.

## Recipe

Run **`cook -n [c|scheme|forth]`** and
get a free template cookbook of your choice on your cwd!

## Install

There's no install command available yet.

    cp cook.sh /usr/local/bin/cook
    gzip -c cook.1 > cook.1.gz
    cp cook.1.gz /usr/share/man/man1/
    mkdir ~/.config/cook
    cp cookbooks/* ~/.config/cook

## LICENCE

This is free and unencumbered software released into the public domain.

Anyone is free to copy, modify, publish, use, compile, sell, or
distribute this software, either in source code form or as a compiled
binary, for any purpose, commercial or non-commercial, and by any
means.

In jurisdictions that recognize copyright laws, the author or authors
of this software dedicate any and all copyright interest in the
software to the public domain. We make this dedication for the benefit
of the public at large and to the detriment of our heirs and
successors. We intend this dedication to be an overt act of
relinquishment in perpetuity of all present and future rights to this
software under copyright law.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.

For more information, please refer to <http://unlicense.org/>
