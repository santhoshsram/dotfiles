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

4. Init and update the git submodules (mostly for vim pathogen). Some of the git submodule paths are SSH based and you may either need to setup SSH access to GitHub or manually update these submodule paths to their HTTPS equivalent.
```
cd ~/dotfiles/
git submodule init
git submodule update
```
