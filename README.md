1. Clone the repo. Setup SSH access to GitHub or use HTTPS repo path.
```
git clone git@github.com:santhoshsram/dotfiles.git ~/dotfiles
```

2. Execute below to create right folders and setup symlinks
```
ln -sf ~/dotfiles/bashrc ~/.bashrc
ln -sf ~/dotfiles/bash_profile ~/.bash_profile
ln -sf ~/dotfiles/vim ~/.vim
ln -sf ~/dotfiles/vimrc ~/.vimrc
ln -sf ~/dotfiles/gitconfig ~/.gitconfig
ln -sf ~/dotfiles/screenrc ~/.screenrc
ln -sf ~/dotfiles/tmux.conf ~/.tmux.conf
ln -sf ~/dotfiles/ssh_config ~/.ssh/config

mkdir -p ~/.config/nvim/lua/config/
mkdir -p ~/.config/nvim/lua/plugins/
mkdir -p ~/.config/ghostty
mkdir -p ~/.vim/pack/plugins/start

ln -sf ~/dotfiles/init.lua ~/.config/nvim/init.lua
ln -sf ~/dotfiles/lazy.lua ~/.config/nvim/config/lazy.lua
ln -sf ~/dotfiles/plugins.lua ~/.config/nvim/config/plugins.lua
ln -sf ~/dotfiles/ghostty_config ~/.config/ghostty/config

# Install vim plugins using native package management (Vim 8+).
cd ~/.vim/pack/plugins/start
git clone https://github.com/catppuccin/vim.git catppuccin
git clone https://github.com/itchyny/lightline.vim.git
git clone https://github.com/tpope/vim-fugitive.git
```

3. Update ~/dotfiles/ssh_config with the right github username and identify file.
