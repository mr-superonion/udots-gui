call plug#begin('~/.vim/plugged')
Plug 'junegunn/vim-easy-align'
Plug 'micha/vim-colors-solarized'
Plug 'mr-superonion/vim-tmux-navigator'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'tpope/vim-commentary'
Plug 'sheerun/vim-polyglot'
Plug 'lervag/vimtex'
Plug 'tpope/vim-fugitive'
call plug#end()

set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath=&runtimepath

" Addons Control
" deoplete
let g:deoplete#enable_at_startup = 1


"vimtex
call deoplete#custom#var('omni', 'input_patterns', {
      \ 'tex': g:vimtex#re#deoplete
      \})
let g:vimtex_view_general_viewer='zathura'
let g:vimtex_view_method='zathura'

" vim-commentary
function UnmapCommentary()
  unmap gc
  nunmap gcc
endfunction

xmap <leader>c  <Plug>Commentary
nmap <leader>c  <Plug>Commentary
omap <leader>c  <Plug>Commentary
nmap <leader>cc <Plug>CommentaryLine

autocmd VimEnter * call UnmapCommentary()

source ~/.vimrc
