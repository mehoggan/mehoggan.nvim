# mehoggan.nvim

Personal Neovim configuration built on top of [LazyVim](https://www.lazyvim.org/).

## Requirements

- Neovim >= 0.10.0 (see LazyVim's [requirements](https://www.lazyvim.org/installation) for the latest minimum version)
- Git
- A [Nerd Font](https://www.nerdfonts.com/) (optional, for icons)
- `ripgrep` and `fd` (for Telescope / file searching)
- A C compiler (for Treesitter parsers)

## Installation

1. Back up your existing Neovim config, if any:

   ```sh
   mv ~/.config/nvim ~/.config/nvim.bak
   mv ~/.local/share/nvim ~/.local/share/nvim.bak
   mv ~/.local/state/nvim ~/.local/state/nvim.bak
   mv ~/.cache/nvim ~/.cache/nvim.bak
   ```

2. Clone this repo into `~/.config/nvim`:

   ```sh
   git clone git@github.com:mehoggan/mehoggan.nvim.git ~/.config/nvim
   ```

3. Start Neovim:

   ```sh
   nvim
   ```

   `lazy.nvim` will bootstrap itself and install all plugins on first launch.

## Updating

Inside Neovim, run `:Lazy sync` to update plugins, and `:LazyExtras` to manage LazyVim extras.
