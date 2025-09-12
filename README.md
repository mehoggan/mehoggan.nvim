# Start Here #

* First clone the repository:

```sh
mkdir -p ~/.config
git@github.com:mehoggan/mehoggan.nvim.git ~/.config/nvim
```

* Second configure lazy.nvim

For installation instructions see: https://lazy.folke.io/installation, which
should be configured after the clone above. If it is not working as desired
follow the instructions in the url above.

* Other steps

1) Install cpptools in nvim `:MasonInstall cpptools`
2) Set environment variables for dsp-nvim (gdb like debugging)
```
export PATH="${PATH}:${HOME}/.local/share/nvim/mason/packages/cpptools/extension/debugAdapters/bin"
export PATH="${PATH}:${HOME}/.local/bin"
```
3) For Linux distributions install `clangdb`
