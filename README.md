# Neovim Configuration

A minimal Neovim configuration with essential plugins and settings for occasional use.

## Installation

1. **Clone the repository:**

   ```sh
   git clone https://github.com/yourusername/your-repo.git ~/.config/nvim
   ```

2. **Bootstrap `lazy.nvim`:**

   The configuration will automatically bootstrap `lazy.nvim` if it is not already installed.

## Key Features

- **Plugin Manager:** [lazy.nvim](https://github.com/folke/lazy.nvim)
- **Color Theme:** Gruvbox
- **Editor Improvements:** Surround, Commenting, Auto Pairs
- **Syntax Highlighting:** Treesitter
- **Search and Navigation:** Telescope, Oil

## Key Mappings

- **Leader Key:** `\`
- **File Explorer:** `<leader>e`
- **Clear Search Highlight:** `,/`
- **Telescope Buffers:** `<C-b>`
- **Telescope Find Files:** `<C-f>`
- **Telescope Live Grep:** `<C-s>`
- **Telescope Diagnostics:** `<C-e>`
- **Comment Toggle (Normal Mode):** `<C-\>`
- **Comment Toggle (Visual Mode):** `<C-\>`

## Additional Settings

- **Cursor Line:** Enabled
- **Line Numbers:** Absolute and Relative
- **Scroll Offset:** 5
- **Undo File:** Enabled
- **Tab Width:** 4 spaces
- **Folding Method:** Treesitter-based

## License

This configuration is open-sourced under the MIT license. See the [LICENSE](LICENSE) file for details.

---

Feel free to customize and extend this configuration to suit your needs. Happy coding!
