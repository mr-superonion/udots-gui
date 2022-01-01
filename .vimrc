" Unused keys
nnoremap s <Nop>
nnoremap x <Nop>
nnoremap X <Nop>
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

" Backspace
set backspace=2
set backspace=indent,eol,start

" Mouse
set ttyfast
set mouse=a
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

set nocompatible              " be iMproved, required
filetype off                  " required by Vundle

" Cursor for insert mode
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"
autocmd VimEnter * silent !echo -ne "\e[2 q"

" Display
" Line number
set nu
set relativenumber
set colorcolumn=80

set history=1000

set exrc
set hidden
set noerrorbells
set scrolloff=8

" Syntax
set showmatch
set guioptions=T
syntax on
set hlsearch

" Automatically wrap text that extends beyond the screen length.
set nowrap

" File system
filetype plugin indent on

" Color setup"
" set background=dark
" let g:solarized_termcolors=256"
" colorscheme solarized
if has('termguicolors')
  set termguicolors
endif
set background=dark

let g:gruvbox_material_background = 'hard'
let g:gruvbox_material_enable_italic = 1
let g:gruvbox_material_disable_italic_comment = 1
colorscheme gruvbox-material
let g:airline_theme= 'gruvbox_material'
" let g:airline_theme='molokai'


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
" set nosmartindent
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
" autocmd BufRead,BufNewFile,BufFilePre *.tex setlocal spell
" autocmd BufWritePost ms*.tex silent! execute "!latexmk -pdf % >/dev/null 2>&1" | redraw!
" autocmd BufWritePost citation.bib silent! execute "!bibtex ms.aux >/dev/null 2>&1" | redraw!

" md
autocmd BufWritePost *.md silent! execute "!pandoc -c http://gfarm.ipmu.jp/~xiangchong.li/me/mystyle.css -s % --mathjax -o '%:r'.html  >/dev/null 2>&1" | redraw!

" Spell check
set spelllang=en
nnoremap <silent> <F11> :set spell!<cr>
inoremap <silent> <F11> <C-O>:set spell!<cr>
highlight SpellBad ctermfg=009 ctermbg=000 cterm=underline

" Mark down
"autocmd BufRead,BufNewFile,BufFilePre *.md nnoremap +f i![<+text+>](<+img+>)<Esc>^
" autocmd BufEnter,BufRead,BufNewFile *.md setlocal spell
" autocmd BufEnter,BufRead,BufNewFile *.tex setlocal spell
" autocmd BufEnter,BufRead,BufNewFile *.md set filetype=markdown


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

" set fileencodings=ucs-bom,utf-8,utf-16,gbk,big5,gb18030,latin1

