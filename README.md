
# Cook

## A bash replacement for make

Read the man page cook.1 for more informations.

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
get a free template recipe of your choice on your cwd!

## Install

To install cook, run cook.sh install.
