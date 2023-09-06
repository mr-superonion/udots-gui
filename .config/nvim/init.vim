" ================================
" Basics and Global Settings
" ================================
set fileencodings=utf-8,utf-16,gbk,big5,gb18030,latin1
set hidden
set noerrorbells
set backspace=indent,eol,start
set nocursorline
" set history=20

" scolling
set ttyfast
set scrolloff=8
set sidescrolloff=10

" line number
set nu
set relativenumber
set mouse=a

" AutoFile generation
set nobackup
set noswapfile
set noundofile

" Split
set splitright
set splitbelow

" Automatically wrap text that extends beyond the screen length.
" set nowrap
set wrap
set linebreak
set noshowmatch

" AutoIndent
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set nosmartindent
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" set formatoptions=tc
" set fo+=a
" set textwidth=80

set incsearch

" Color
if exists('+termguicolors')
    set termguicolors
endif

nnoremap <SPACE> <Nop>
let g:mapleader=" "
let maplocalleader = " "

call plug#begin('~/.vim/plugged')
    " display
    Plug 'sainnhe/gruvbox-material'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'tpope/vim-commentary'
    Plug 'mr-superonion/vim-tmux-navigator'
    Plug 'MattesGroeger/vim-bookmarks'
    Plug 'preservim/tagbar'
    " txt (latex/markdown)
    Plug 'lervag/vimtex'
    Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
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
    Plug 'honza/vim-snippets'
call plug#end()

" Color setup"
set background=dark
set colorcolumn=80

let g:gruvbox_material_background = 'hard'
let g:gruvbox_material_enable_italic = 1
let g:gruvbox_material_disable_italic_comment = 1
let g:airline_theme= 'gruvbox_material'
colorscheme gruvbox-material

" display airline
set cmdheight=1
set noshowmode  " to get rid of thing like --INSERT--
set noshowcmd  " to get rid of display of last command
set shortmess+=F  " to get rid of the file name displayed in the command line bar

" vimtex
let g:vimtex_view_general_viewer='zathura'
let g:vimtex_view_method='zathura'
" let g:vimtex_compiler_method = 'latexrun'

let g:vimtex_motion_matchparen = 0
let g:vimtex_indent_enabled = 0
let g:vimtex_indent_bib_enabled = 0
let g:vimtex_syntax_conceal_disable = 1

let g:vimtex_toc_config = {
    \'split_pos'   : ':vert :botright',
    \'split_width':  50,
    \}

hi link texMathZoneG texMathZoneEnv
hi link texMathZoneGS texMathZoneEnvStarred
hi link texMathZoneW texMathZone
hi link texMathZoneX texMathZoneX
hi link texMathZoneY texMathZoneXX
hi link texMathZoneZ texMathZoneEnsured
hi link texStatement texCmd

" markdown preview
let g:mkdp_refresh_slow = 1
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
let g:mkdp_browser = '/usr/bin/brave'
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
lua require("tele")
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
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
inoremap <silent><expr> <C-x><C-z> coc#pum#visible() ? coc#pum#stop() : "\<C-x>\<C-z>"
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')
autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-n>'
" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-p>'

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

hi CocSearch ctermfg=12 guifg=#18A3FF
hi CocMenuSel ctermbg=109 guibg=#13354A

" Git fugitive
nnoremap <leader>gl :diffget //3
nnoremap <leader>gh :diffget //2
nnoremap <leader>gs :G<CR>

" Tag bar
nnoremap <silent> <F10> :TagbarToggle<CR>
nnoremap ]] <cmd>TagbarJumpNext<cr>
nnoremap [[ <cmd>TagbarJumpPrev<cr>
nnoremap <leader>tt <cmd>TagbarToggle<cr>
let g:tagbar_width = max([40, winwidth(0) / 4])

" Unused keys
nnoremap s <Nop>

nnoremap J 10<c-e>
nnoremap K 10<c-y>
inoremap <C-N> <Nop>
inoremap <C-P> <Nop>

" Search and Substitute
" Replace all is aliased to S.
vnoremap <C-f> y:Telescope grep_string search=<C-R>=@"<CR><CR>
nnoremap <C-f> :Telescope grep_string search=
nnoremap S :%s///g<Left><Left>
vnoremap // "zy/\V<C-R>=escape(@z,'/\')<CR><CR>

" Move in command and input mode
nnoremap { {zzzv
nnoremap } }zzzv
nnoremap n nzzzv
nnoremap p pzzzv


" Mouse
vnoremap <C-C> y
nnoremap <C-V> p

"" Wildmenu
cnoremap <expr> <up> wildmenumode() ? "\<left>" : "\<up>"
cnoremap <expr> <down> wildmenumode() ? "\<right>" : "\<down>"
cnoremap <expr> <left> wildmenumode() ? "\<up>" : "\<left>"
cnoremap <expr> <right> wildmenumode() ? " \<bs>\<C-Z>" : "\<right>"
"" Search files and provide tab-completion for all file related tasks
set path+=**
" display all matching files when tab complete
set wildmenu
set wildmode=longest:full,full
let &wildcharm = &wildchar
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " binary images
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
set wildignore+=*.spl                            " compiled spelling word lists
set wildignore+=*.sw?                            " Vim swap files
set wildignore+=*.DS_Store                       " OSX bullshit
set wildignore+=migrations                       " Django migrations
set wildignore+=*.pyc                            " Python byte code

" Basics
nnoremap Y y$
nnoremap yy Y
nnoremap V v$
nnoremap vv V

" Cursor for insert mode
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"
autocmd VimEnter * silent !echo -ne "\e[2 q"

" Window Control
nnoremap <C-w>" :wincmd =<CR>
nnoremap <C-w>= :new<CR>
nnoremap <C-w>% :vnew<CR>
nnoremap <C-w>x :q!<CR>

" Copy and paste
" clipboard
nnoremap x "_d
xnoremap x "_d
nnoremap xx "_dd
nnoremap X "_D
" " Vim's auto indentation feature does not work properly with text copied
" from outside of Vim. Press the <F2> key to toggle paste mode on/off.
nnoremap <F2> :set invpaste paste?<CR>
imap <F2> <C-O>:set invpaste paste?<CR>
set pastetoggle=<F2>
set clipboard=unnamedplus
" let @*=@+

imap (( <Nop>
imap [[ <Nop>
imap {{ <Nop>
inoremap (( ()<Esc>i
inoremap [[ []<Esc>i
inoremap {{ {}<Esc>i
inoremap << <><Esc>i
inoremap '' ''<Esc>i
inoremap "" ""<Esc>i

nnoremap \\ <Esc>/<+\h*+><Enter>"_ca>
nnoremap <Bar><Bar> <Esc>/<+\h*+><Enter><S-N>"_ca>

nnoremap j gj
nnoremap k gk
nnoremap $ g$
nnoremap 0 g0

augroup markdown_autocmds
    autocmd!
    autocmd BufEnter,BufRead,BufNewFile *.md setlocal spell
    autocmd BufEnter,BufRead,BufNewFile *.md syntax on
augroup END

augroup tex_autocmds
    autocmd!
    autocmd BufEnter,BufRead,BufNewFile *.tex setlocal spell
    autocmd BufEnter,BufRead,BufNewFile *.tex syntax on
augroup END

" Spell check
set spelllang=en
nnoremap <silent> <F11> :set spell!<CR>
inoremap <silent> <F11> <C-O>:set spell!<CR>
highlight SpellBad ctermfg=009 ctermbg=000 cterm=underline


" All files
" Automatically deletes all trailing whitespace on save.
autocmd BufWritePre * %s/\s\+$//e
" Return to last edit position when opening files -------- "
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
" Remember info about open buffers on close -------------- "
set viminfo^=%

nnoremap <C-t> :tabnew<CR>
nnoremap <S-l> :tabnext<CR>
nnoremap <S-h> :tabprevious<CR>


""<++>
" Visual mode yank selected area to tmux paste buffer (clipboard)
vnoremap <leader>y "zy:silent! call SendZBufferToHomeDotClipboard()<CR>
" Put from tmux clipboard
nnoremap <leader>p :silent! call HomeDotClipboardPut()<CR>

function! SendZBufferToHomeDotClipboard()
    " Yank the contents buffer z to file ~/.clipboard and tmux paste buffer
    " For use with HomeDotClipboardPut()
    silent! redir! > ~/.clipboard
    silent! echon @z
    silent! redir END
endfunction

function! HomeDotClipboardPut()
    " Paste/Put the contents of file ~/.clipboard
    " For use with SendZBufferToHomeDotClipboard()
    exe 'let @z=""'
    silent! let @z = system("cat ~/.clipboard")
    " put the z buffer on the line below
    silent! norm "zp
endfunction

syntax enable
filetype plugin indent on
