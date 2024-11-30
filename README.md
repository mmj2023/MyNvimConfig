# MyNvimConfig

## Introduction

This is my personal neovim configuration.
It's not that good in terms of functionality(personaly I think that I could have made it better) or speed(relative to any neovim ditributions) but someone can take inspiration from it. 
Although the ui aspects might be pleasing. It has a ton of lsp setups, linters and formatters .Very unnecessary, you can clone the repo either full or shallow clone (git clone --depth=1 <filename>) and it would load everything as long as you have all of the dependencies.
**NOT** a Neovim distribution, but instead a reference point for your configuration.
<!-- ## Requirements -->
<!---->
<!-- - Neovim >= 0.10.0(Currenly I'm using v0.11.0-dev-574+g0c2860d9e) -->
<!-- - Treesitter -->
<!-- <!-- - LSP --> -->
<!-- <!-- - Formatters --> -->
<!-- <!-- - Linters --> -->
<!-- <!-- - Autocompletion --> -->
<!-- <!-- - Telescope --> -->
<!-- <!-- - Oil --> -->
<!-- <!-- - Gitsigns --> -->
<!-- <!-- - Gitgutter --> -->
<!-- - Git(prefered) -->
<!-- - C/C++ Compiler -->
<!-- - Pip -->
<!-- - Node -->
<!-- - Cargo -->
<!---->
## Installation
### Install Neovim

MyNvimConfig targets *only* the most recent stable release of Neovim(still differences might exist).Lastest stable release of Neovim
['stable'](https://github.com/neovim/neovim/releases/tag/stable) and latest
['nightly'](https://github.com/neovim/neovim/releases/tag/nightly) of Neovim.
If you are experiencing issues, please make sure you have the latest versions.
### Install External Dependencies

External Requirements:
- Basic utils: `git`, `make`, `unzip`, C Compiler (`gcc`)
- [ripgrep](https://github.com/BurntSushi/ripgrep#installation)
- Clipboard tool (xclip/xsel/win32yank or other depending on platform)
- A [Nerd Font](https://www.nerdfonts.com/): optional, provides various icons
  <!-- - if you have it set `vim.g.have_nerd_font` in `init.lua` to true -->
- Language Setup:
  - If you want to write Typescript, you need `npm`
  - If you want to write Golang, you will need `go`
  - etc.

## 🚀 Getting Started

<!-- You can find a starter template for **LazyVim** [here](https://github.com/LazyVim/starter) -->

<!-- <details><summary>Try it with Docker</summary> -->
<!---->
<!-- ```sh -->
<!-- docker run -w /root -it --rm alpine:edge sh -uelic ' -->
<!--   apk add git lazygit neovim ripgrep alpine-sdk --update -->
<!--   git clone https://github.com/LazyVim/starter ~/.config/nvim -->
<!--   cd ~/.config/nvim -->
<!--   nvim -->
<!-- ' -->
<!-- ``` -->
<!---->
<!-- </details> -->

<details><summary>You can use this repo as your starter config(You shouldn't if you don't know what you are doing, the Treesitter, Lsp and linter setup needs to be improved.) but you probably wanna start with something like <a href="https://github.com/nvim-lua/kickstart.nvim">kickstart.nvim</a></summary>

- Make a backup of your current Neovim files:

  ```sh
  mv ~/.config/nvim ~/.config/nvim.bak
  mv ~/.local/share/nvim ~/.local/share/nvim.bak
  ```

- Clone the repo:

  ```sh
  git clone https://github.com/mmj2023/MyNvimConfig ~/.config/nvim
  ```
  Or, if you just use the latest version:

  ```sh
  git clone --depth=1 https://github.com/mmj2023/MyNvimConfig ~/.config/nvim
  ```

- Remove the `.git` folder, so you can add it to your own repo later

  ```sh
  rm -rf ~/.config/nvim/.git
  ```
  If you want to.

- Start Neovim!

  ```sh
  nvim
  ```

  <!-- Refer to the comments in the files on how to customize **LazyVim**. -->

</details>

---

  ## Credits

- [Kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim)
- [LazyVim](https://github.com/LazyVim/LazyVim)
- [NvChad](https://github.com/NvChad/NvChad)
- [AstroNvim](https://github.com/AstroNvim/AstroNvim)
