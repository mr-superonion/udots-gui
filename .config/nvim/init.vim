nnoremap <SPACE> <Nop>

call plug#begin('~/.vim/plugged')
    " display
    Plug 'tpope/vim-commentary'
    Plug 'junegunn/vim-easy-align'
    Plug 'micha/vim-colors-solarized'
    Plug 'mr-superonion/vim-tmux-navigator'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    " latex
    Plug 'lervag/vimtex'
    " git
    Plug 'tpope/vim-fugitive'
    " files
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    " autocomplete
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath=&runtimepath

" display
" airline
let g:airline_theme='molokai'
"let g:airline_solarized_bg='dark'
set cmdheight=1
set noshowmode  " to get rid of thing like --INSERT--
set noshowcmd  " to get rid of display of last command
set shortmess+=F  " to get rid of the file name displayed in the command line bar

"vimtex
let g:vimtex_compiler_latexmk = {
    \ 'options' : [
    \   '-pdf',
    \   '-pdflatex="xelatex --shell-escape %O %S"',
    \   '-verbose',
    \   '-file-line-error',
    \   '-synctex=1',
    \   '-interaction=nonstopmode',
    \ ]
    \}

let g:vimtex_view_general_viewer='zathura'
let g:vimtex_view_method='zathura'

" vim-commentary
function UnmapCommentary()
  unmap gc
  nunmap gcc
endfunction
autocmd VimEnter * call UnmapCommentary()

xmap <leader>c  <Plug>Commentary
omap <leader>c  <Plug>Commentary
nmap <leader>cc <Plug>CommentaryLine


" telescope
" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Using Lua functions
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>

" autocomplete
inoremap <silent><expr> <c-i> coc#refresh()
" Give more space for displaying messages.

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

source ~/.vimrc
