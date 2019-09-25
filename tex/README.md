# LaTeX setup

## Creating a new LaTeX template

The `create_base.sh` command is aliased as `newtex` in my `.bash_alias` file, so that when I want to create (for instance) some notes, I can just use the command `newtex -n <folder_name>` at the command line.  This can similarly be used to create a template for presentations with `newtex -p <folder_name>` or full papers with `newtex -f <folder_name>`.To use in your own setup, you will have to modify `create_base.sh` to put in the absolute path to this directory. 

## Making custom packages

Running `refresh_packages.sh` will add the contents of `custom-pkg/` (such as `header.sty`) to the global set of available LaTeX packages, so that e.g., the `header` package is available globally.  For projects on Overleaf, the `custom-pkg/header.sty` package should be copied over directly.

## Compiling LaTeX documents

I use vimtex to compile LaTeX documents, so I do not include a Makefile here.
