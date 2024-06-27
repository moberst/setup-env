# Install latest python
env PYTHON_CONFIGURE_OPTS='--enable-optimizations --with-lto' \
  PYTHON_CFLAGS='-march=native -mtune=native' \
  pyenv install 3.11

# Create nvim virtualenv
pyenv virtualenv 3.11 nvim
pyenv activate nvim
pip install pynvim

# Create basic virtualenv
pyenv virtualenv 3.11 basic
pyenv activate basic
pip install pandas numpy scikit-learn matplotlib seaborn ipython

pyenv global basic
