# Vim

## Setting up Vim

**Caveat**: I have not done this in a while, may require some tinkering

`setup-sudo.sh` and `setup-no-sudo.sh` should work to install a fresh instance of Vim, locally in the case of no sudo access (e.g., on the server)

## Customizing Vim

There are two aspects of customizing vim, both of which are refreshed when `configure.sh` is run. 

First, it will install packages.  Look at `install_pack.sh` to see what it installs.  If you see `start` in a group of packages, this means that it will be available by default, e.g.,
```
set_group snips start
```

Second, it will copy `vimrc` to `./.vimrc` in your home directory
