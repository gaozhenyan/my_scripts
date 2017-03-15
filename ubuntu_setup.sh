#!/bin/sh

mkdir -p tmp
#Add ppas and update
sudo apt -y install software-properties-common
sudo add-apt-repository -y ppa:neovim-ppa/stable
sudo apt update

#Install softwares
sudo apt -y install build-essential
sudo apt -y install clang clang-format
sudo apt -y install git gitg qgit subversion meld
sudo apt -y install cscope ctags
sudo apt -y install bison flex
sudo apt -y install cmake automake autoconf libtool m4
sudo apt -y install bpython bpython3
sudo apt -y install minicom
sudo apt -y install openssh-server tftp-hpa tftpd-hpa
sudo apt -y install --no-install-recommends gem
sudo apt -y install --no-install-recommends curl wget

#
cp ./bashrc ${HOME}/.bashrc

#tmux
sudo apt -y install tmux
sudo gem install tmuxinator
git clone https://github.com/tmuxinator/tmuxinator.git tmp/tmuxinator
sudo cp tmp/tmuxinator/completion/tmuxinator.bash /etc/bash_completion.d/

mkdir -p ${HOME}/.tmuxinator
cp ./tmuxinator/sys_mgr.yml ${HOME}/.tmuxinator
pushd ${HOME}
git clone https://github.com/gpakosz/.tmux.git
ln -s -f .tmux/.tmux.conf
popd
cp ./tmux/tmux.conf.local ${HOME}/.tmux.conf.local

# zsh
sudo apt -y install zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

#configure Git
./gitconfig

#configure cscope and ctags
sudo cp ./gen_cscope_tags /usr/bin

#configure vim and neovim
sudo apt purge vim-tiny
sudo apt -y install vim-gnome
sudo apt -y install neovim
sudo apt -y install python-dev python-pip python3-dev python3-pip
sudo apt -y install xclip xsel
sudo -H pip install neovim
sudo -H pip3 install neovim
sudo update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 60
sudo update-alternatives --set vi /usr/bin/nvim
sudo update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 60
sudo update-alternatives --set editor /usr/bin/nvim
#rm -rf .vim
git clone git@git.oschina.net:gaozhenyan/vimrc.git ${HOME}/.vim
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
mkdir ~/.config/nvim
rm -rf ${HOME}/.config/nvim/init.vim
ln -s ${HOME}/.vim/vimrc ${HOME}/.config/nvim/init.vim
vi -c "BundleInstall" -c "exit" -c "exit"

pushd ${HOME}/.vim/bundle/YouCompleteMe
./install.py --clang-completer
popd
