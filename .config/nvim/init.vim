nnoremap <SPACE> <Nop>
let g:mapleader=" "
let maplocalleader = " "

call plug#begin('~/.vim/plugged')
    " display
    Plug 'tpope/vim-commentary'
    " Plug 'junegunn/vim-easy-align'
    " Plug 'micha/vim-colors-solarized'
    Plug 'sainnhe/gruvbox-material'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'mr-superonion/vim-tmux-navigator'
    Plug 'MattesGroeger/vim-bookmarks'
    Plug 'preservim/tagbar'
    " txt (latex/markdown)
    Plug 'lervag/vimtex'
    Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
    " git
    Plug 'tpope/vim-fugitive'
    " files
    Plug 'nvim-lua/popup.nvim'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'nvim-telescope/telescope-fzf-native.nvim', {'do': 'make'}
    Plug 'nvim-telescope/telescope-file-browser.nvim'
    " autocomplete
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

" display airline
set cmdheight=1
set noshowmode  " to get rid of thing like --INSERT--
set noshowcmd  " to get rid of display of last command
set shortmess+=F  " to get rid of the file name displayed in the command line bar

" vimtex
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
hi link texMathZoneG texMathZoneEnv
hi link texMathZoneGS texMathZoneEnvStarred
hi link texMathZoneW texMathZone
hi link texMathZoneX texMathZoneX
hi link texMathZoneY texMathZoneXX
hi link texMathZoneZ texMathZoneEnsured
hi link texStatement texCmd

" markdown preview
let g:mkdp_refresh_slow = 1
let g:mkdp_browser = 'brave'
let g:mkdp_markdown_css = expand('~/Documents/public_html/me/mystyle.css')
nnoremap <leader>mv <cmd>MarkdownPreviewToggle<cr>
let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1,
    \ 'sequence_diagrams': {},
    \ 'flowchart_diagrams': {},
    \ 'content_editable': v:false,
    \ 'disable_filename': 0
    \ }
let g:mkdp_filetypes = ['markdown']

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
" lua setups
lua require("xtele")
" Find files using Telescope command-line sugar.
nnoremap <leader>fr <cmd>Telescope resume<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fv <cmd>Telescope current_buffer_fuzzy_find<cr>
" Using Lua functions
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>

" COC
" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300
" Don't pass messages to |ins-completion-menu|.
set shortmess+=c
" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=number
" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gp <Plug>(coc-diagnostic-prev)
nmap <silent> gn <Plug>(coc-diagnostic-next)

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')
autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')

" show documentation in preview window.
inoremap <silent> <C-\> <C-r>=CocActionAsync('showSignatureHelp')<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" " Make <CR> auto-select the first completion item and notify coc.nvim to
" " format on enter, <cr> could be remapped by other vim plugin
" inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
"                       \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Git fugitive
nnoremap <leader>gl :diffget //3
nnoremap <leader>gh :diffget //2
nnoremap <leader>gs :G<CR>

source ~/.vimrc
