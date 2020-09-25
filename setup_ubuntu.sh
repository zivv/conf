#!/usr/bin/env bash
#
# To setup through SSH:
#   scp setup_ubuntu.sh $SERVER:~/tmp && ssh -t $SERVER './tmp && rm tmp'

set -ex

# Open Terminal->Preferences->Colors, set 'Text and Background Color' as
# 'Solarized dark' and 'Palette' as 'Solarized'.

sudo apt install -y curl python3-pip zsh tmux vim-gtk3 xclip tree git
pip3 install psutil powerline-status trash-cli

# Optional:
# sudo apt install -y net-tools ibus-pinyin mosh netcat-openbsd
# sudo apt install -y build-essential cmake exuberant-ctags clang-format
# pip3 install autopep8

mkdir -p ~/.local/share/fonts
pushd ~/.local/share/fonts
# https://github.com/powerline/fonts
url="https://github.com/powerline/fonts/raw/master/"
url+="SourceCodePro/Source%20Code%20Pro%20Semibold%20for%20Powerline.otf"
curl -Lo "Source Code Pro Semibold for Powerline.otf" $url
# https://github.com/ryanoasis/nerd-fonts
url="https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/"
url+="Hack/Regular/complete/"
url+="Hack%20Regular%20Nerd%20Font%20Complete%20Mono.ttf"
curl -Lo "Hack Regular Nerd Font Complete Mono.ttf" $url
fc-cache -vf
# Check:
# fc-list | grep Powerline
# fc-list | grep Nerd
popd

# Open Terminal->Preferences->Text, set 'Custom font' as
# 'Source Code Pro for Powerline Semibold | 15'.

curl -Lo ~/.dircolors.256dark \
  https://raw.github.com/seebi/dircolors-solarized/master/dircolors.256dark

sh -c "$(curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
sed -i 's/^ZSH_THEME\|^plugins=\|^source/#&/g' ~/.zshrc
git clone git://github.com/zsh-users/zsh-autosuggestions \
  $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions
echo "[[ -f ~/.sh_base ]] && . ~/.sh_base" >>~/.zshrc && source ~/.zshrc

git clone --depth=1 https://github.com/zivv/conf ~/conf &&
  (cd ~/conf && ./set.sh)

# Recommend: rsync -avhP ~/.vim $SERVER:
# git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
# vim -c "PluginInstall" -c q
# git clone https://github.com/zivv/UltiSnips.git ~/.vim/UltiSnips

# Reboot it!

# For server:
# unalias rm && rm -r ~/conf
# Clean the content of ~/.sh_base, ~/.bash_local, ~/.zsh_local
# Consider change 'ZSH_TMUX_AUTOSTART=true' to 'false' in ~/.zsh_local.
