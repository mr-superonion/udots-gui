call plug#begin('~/.vim/plugged')
Plug 'junegunn/vim-easy-align'
Plug 'micha/vim-colors-solarized'
Plug 'mr-superonion/vim-tmux-navigator'
call plug#end()

set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath=&runtimepath

" Addons Control

source ~/.vimrc
