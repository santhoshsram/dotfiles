1. Clone the repo. Setup SSH access to GitHub or use HTTPS repo path.
```
git clone git@github.com:santhoshsram/dotfiles.git ~/dotfiles
```

2. Install GNU Stow
```
brew install stow
```

3. Set up symlinks using stow
```
cd ~/dotfiles
stow bash git vim nvim ghostty tmux screen ssh claude
```

Note: `~/.ssh/` must exist before stowing ssh (`mkdir -p ~/.ssh && chmod 700 ~/.ssh`).

4. Install vim plugins using native package management (Vim 8+).
```
mkdir -p ~/.vim/pack/plugins/start
cd ~/.vim/pack/plugins/start
git clone https://github.com/catppuccin/vim.git catppuccin
git clone https://github.com/itchyny/lightline.vim.git
git clone https://github.com/tpope/vim-fugitive.git
```

5. Update `~/dotfiles/ssh/.ssh/config` with the right github username and identity file.

6. Set up tmux plugins.

Install TPM (Tmux Plugin Manager):
```
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

Install the Nerd Fonts
```
# JetBrains Mono NF
brew install --cask font-jetbrains-mono-nerd-font

# SauceCodePro NF
brew install --cask font-sauce-code-pro-nerd-font

# Maple Mono NF
brew install --cask font-maple-mono-nf
```

If any icons or glyphs don't render correctly, also install Commit Mono Nerd Font:
```
brew install --cask font-commit-mono-nerd-font
```

Start a new tmux session, then press `Ctrl+Space I` (Prefix + I) to install all plugins.

7. Claude Code statusline

The `claude` package installs a statusline script for Claude Code (`~/.claude/statusline-command.sh`).
After stowing, point Claude Code to it by adding the following to `~/.claude/settings.json`:
```json
"statusLine": {
  "type": "command",
  "command": "bash ~/.claude/statusline-command.sh"
}
```

8. Bash history search using fzf
```
# First install bash via homebrew. Default macOS bash is very old.
brew install bash

# Add new bash to allowed shells
sudo sh -c 'echo "$(brew --prefix)/bin/bash" >> /etc/shells'

# Change default shell to new bash
chsh -s "$(brew --prefix)/bin/bash"

# Install fzf
brew install fzf

# Install fzf keybindings and autocomplete
$(brew --prefix)/opt/fzf/install
```
