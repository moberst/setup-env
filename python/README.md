# Install miniconda

Run `bash setup.sh -m` to install miniconda (leave out the `-m` flag to install full Anaconda)

# Installing specific packages

Each of the sub-directories exists to install and configure certain packages

# Conda environments

The `envs` folder stores `.yml` files which can be used to create conda 
environments using the command 

```
conda env create -f $YML_FILE
```
# NOTE

Convention (in bashrc) is to install miniconda on a new system, and put it in a dotfile directory
