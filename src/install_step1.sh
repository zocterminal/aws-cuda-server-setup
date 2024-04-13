#!/bin/bash
# vim: ff=unix 

cat <<EOF >.bash_aliases
alias ll='ls -l'
alias lla='ls -la'
alias ..='cd ..'
alias cd..='cd ..'
alias copy='cp'
alias dir='ls -l'
alias findit='function findit() {  find . -name "$1" -print; }; findit '
EOF

cat <<EOF >.vimrc
set sw=4
set ts=4
set modeline
set visualbell
set background=dark
set modeline
set modelines=5
syntax on
highlight comment ctermfg=darkgreen
map V :w<CR>:n<CR>
EOF

mkdir bin
export PATH="$HOME/bin:$PATH"

sudo chmod 644 /etc/update-motd.d/10-* /etc/update-motd.d/88-* /etc/update-motd.d/90-*

sudo apt update -y
sudo apt upgrade -y
sudo apt install -y zip unzip wget dos2unix lrzsz
sudo apt install -y git build-essential net-tools bc
sudo apt install -y python3 python3-venv python3-pip

echo ''
echo 'Now continue with step 2 for installation of NVIDIA-CUDA'
echo ''

