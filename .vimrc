" Unused keys
nnoremap s <Nop>
nnoremap x <Nop>
nnoremap X <Nop>
nnoremap J <Nop>
nnoremap K <Nop>
inoremap <C-N> <Nop>
inoremap <C-P> <Nop>

" Substitute
" Replace all is aliased to S.
nnoremap S :%s///g<Left><Left>

" Move in command and input mode
nnoremap { {zz
nnoremap } }zz

" Backspace
set backspace=2
set backspace=indent,eol,start

" Mouse
set ttyfast
set ttymouse=xterm2
set mouse=a
vnoremap <C-C> y
nnoremap <C-V> p

"" Search down to the files
"" and provide tab-completion for all file related tasks
set path+=**
" display all matching files when tab complete
set wildmenu
set wildmode=longest:full,full
let &wildcharm = &wildchar

" Basics
nnoremap Y y$
nnoremap yy Y
nnoremap V v$
nnoremap vv V

set nocompatible              " be iMproved, required
filetype off                  " required by Vundle

" Cursor for insert mode
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"
autocmd VimEnter * silent !echo -ne "\e[2 q"

" Display
" Line number
set relativenumber
set nu
set history=1000
" Syntax
set showmatch
set guioptions=T
syntax on
set hlsearch

" Automatically wrap text that extends beyond the screen length.
set wrap

" Addons Control
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle
Plugin 'VundleVim/Vundle.vim'
Plugin 'micha/vim-colors-solarized'
Plugin 'AutoComplPop'
Plugin 'superonion1993/vim-tmux-navigator'
call vundle#end()

" File system
filetype plugin indent on
filetype plugin on

" AutoComplPop
let g:acp_behaviorCssOmniPropertyLength = -1
let g:acp_behaviorCssOmniValueLength = -1
let g:acp_behaviorHtmlOmniLength = -1
let g:acp_behaviorXmlOmniLength = -1
let g:acp_behaviorPythonOmniLength = -1
let g:acp_behaviorKeywordLength = 3
let g:acp_completeOption = '.,w,b'

" Color setup"
set background=dark
" let g:solarized_termcolors=256"
colorscheme solarized

" Window Control
nnoremap <C-w>" :wincmd =<CR>
nnoremap <C-w>= :new<CR>
nnoremap <C-w>% :vnew<CR>
nnoremap <C-w>x :q!<CR>

" Split
set splitright
set splitbelow

" AutoIndent
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set nosmartindent
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o


" AutoFile generation
set nobackup
set noswapfile
set noundofile


" Copy and paste
" " Vim's auto indentation feature does not work properly with text copied
" from outside of Vim. Press the <F2> key to toggle paste mode on/off.
nnoremap <F2> :set invpaste paste?<CR>
imap <F2> <C-O>:set invpaste paste?<CR>
set pastetoggle=<F2>
set clipboard=unnamedplus
let @*=@+

""<++>
" Visual mode yank selected area to tmux paste buffer (clipboard)
vnoremap <leader>y "zy:silent! call SendZBufferToHomeDotClipboard()<cr>
" Put from tmux clipboard
nnoremap <leader>p :silent! call HomeDotClipboardPut()<cr>

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

inoremap (( ()<Esc>i
inoremap [[ []<Esc>i
inoremap {{ {}<Esc>i
inoremap << <><Esc>i
inoremap '' ''<Esc>i
inoremap "" ""<Esc>i

nnoremap \\ <Esc>/<+\h*+><Enter>"_ca>
nnoremap <Bar><Bar> <Esc>/<+\h*+><Enter><S-N>"_ca>

" Auto commands

" For text
" tex
""autocmd BufRead,BufNewFile,BufFilePre *.tex setlocal spell
autocmd BufWritePost main.tex silent! execute "!pdflatex % >/dev/null 2>&1" | redraw!


" Mark down
"autocmd BufRead,BufNewFile,BufFilePre *.md setlocal spell
"autocmd BufNewFile,BufFilePre,BufRead *.md set filetype=markdown
"autocmd BufRead,BufNewFile,BufFilePre *.md nnoremap +f i![<+text+>](<+img+>)<Esc>^

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
nnoremap <C-tab> :tabprevious<CR>
nnoremap <C-S-tab> :tabnext<CR>
