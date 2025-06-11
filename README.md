1. Clone the repo. Setup SSH access to GitHub or use HTTPS repo path.
```
git clone git@github.com:santhoshsram/dotfiles.git ~/dotfiles
```

2. Create the following symlinks
```
ln -sf ~/dotfiles/bashrc ~/.bashrc
ln -sf ~/dotfiles/vim ~/.vim
ln -sf ~/dotfiles/vimrc ~/.vimrc
ln -sf ~/dotfiles/gitconfig ~/.gitconfig
ln -sf ~/dotfiles/screenrc ~/.screenrc
ln -sf ~/dotfiles/tmux.conf ~/.tmux.conf
ln -sf ~/dotfiles/ssh_config ~/.ssh/config
```

3. Update ~/dotfiles/ssh_config with the right github username and identify file.

4. Install vim plugins using native package management (Vim 8+). The vim configuration uses native package management instead of pathogen. Plugins installed in `~/.vim/pack/plugins/start/` will be automatically loaded by vim.
```bash
# Create the native package directory structure
mkdir -p ~/.vim/pack/plugins/start

# Install plugins
cd ~/.vim/pack/plugins/start

# Install catppuccin theme
git clone https://github.com/catppuccin/vim.git catppuccin

# Install lightline for status bar
git clone https://github.com/itchyny/lightline.vim.git

# Install fugitive for git integration
git clone https://github.com/tpope/vim-fugitive.git

# Optional: Install other plugins as needed
# git clone https://github.com/plugin-author/plugin-name.git
```
