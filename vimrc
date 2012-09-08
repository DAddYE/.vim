set nocompatible
syntax on
set nospell
set number
set numberwidth=5

set nocursorcolumn
set nocursorline
set encoding=utf-8
set title
set shortmess=atI " don't sho intro messages
set report=0      " tell us about changes
set backspace=indent,eol,start " allow backspacing over everything in insert mode

set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

set ruler
set nowrap
set list
set listchars=tab:\ ·,trail:·
set lazyredraw
set matchtime=3
set showbreak=↪
set splitbelow
set splitright
set fillchars=vert:\ " empty is nicer on our term
set autowrite
set shiftround
set autoread
set linebreak
set hlsearch
set incsearch
set ignorecase
set smartcase
set laststatus=2

set clipboard+=unnamed " Share your clipboard with system
set mouse=a            " Make mouse working!
set modeline
set modelines=10

set wildmode=list:longest,list:full  " Tab completion
set wildignore+=*.o,*.out,*.obj,.git,*.rbc,*.class,.svn,*.gem
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz
set wildignore+=*/vendor/gems/*,*/vendor/cache/*,*/.bundle/*,*/.sass-cache/*
set wildignore+=*.swp,*~,._*

set showcmd " Show (partial) command in the status line"
set showmode
set completefunc=syntaxcomplete#Complete " Minitest autocompletion

set history=1000                      " Store lots of :cmdline history
set backupdir=~/.vim/tmp/backup/      " where to put backup files.
set directory=~/.vim/tmp/swap/        " where to put swap files.
set backupskip=/tmp/*,/private/tmp/*  " make Vim able to edit crontab files again.
set backup                            " enable backups
set noswapfile                        " It's 2012, Vim.
set undodir=~/.vim/undo/
set undofile

set nostartofline " Don’t reset cursor to start of line when moving around.
set esckeys " Allow cursor keys in insert mode
set ttyfast " Optimize for fast terminal connections
set isk+=_,$,@,%,#,- " none word dividers

" Time out on key codes but not mappings.
" Basically this makes terminal Vim work sanely.
set notimeout
set ttimeout
set ttimeoutlen=10

" Write better
set cc=100

" Colors & C.
set background=dark
colorscheme Tomorrow

" Make bolds match gui version
hi! Statement  cterm=bold
hi! Type       cterm=bold

" IndentGuides <leader>ig
let g:indent_guides_auto_colors=0
let g:indent_guides_enable_on_vim_startup=1
hi IndentGuidesOdd  guibg=#2b2b2b ctermbg=0
hi IndentGuidesEven guibg=#3a3838 ctermbg=10

" let g:solarized_termtrans=1
" let g:solarized_termcolors=256
" let g:solarized_contrast="high"
" let g:solarized_visibility="high"
" colorscheme solarized

filetype plugin indent on      " load the plugin and indent settings for the detected filetype
" runtime! macros/matchit.vim  " % to bounce from do to end etc.

" Change mapleader
" let mapleader=","

" Verical bar in insert mode (for iTerm users only)
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

" Save when losing focus
au FocusLost * :silent! wall
"
" Resize splits when the window is resized
au VimResized * :wincmd =

" Taskspaper
let g:task_paper_date_format = "%d/%m/%y %H:%M"

" Ctrlp
let g:ctrlp_working_path_mode = 0
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|\.hg$\|\.svn$',
  \ 'file': '\.pyc$\|\.pyo$\|\.rbc$|\.rbo$\|\.class$\|\.o$\|\~$\|\.DS_Store'
  \ }


" remember last location in file, but not for commit messages.
au BufReadPost * if &filetype !~ '^git\c' && line("'\"") > 0 && line("'\"") <= line("$")
      \| exe "normal! g`\"" | endif

au FileType *    set expandtab   " others not
au FileType make set noexpandtab " make uses real tabs"

" Thorfile, Rakefile, GuardFile, Vagrantfile and Gemfile are Ruby
au BufRead,BufNewFile {Gemfile,Rakefile,Guardfile,Vagrantfile,Thorfile,Do,dorc,Dofile,config.ru} set ft=ruby

" Be sure to don't open markdown files with modula2 syntax
au BufRead,BufNewFile *.md set ft=markdown

" add json syntax highlighting
au BufNewFile,BufRead *.json set ft=javascript

" make Python follow PEP8 ( http://www.python.org/dev/peps/pep-0008/ )
au FileType python set softtabstop=4 tabstop=4 shiftwidth=4 textwidth=79

" nginx highlight
augroup Nginx
  au BufRead,BufNewFile /etc/nginx/conf/* set ft=nginx
  au BufRead,BufNewFile /opt/nginx/conf/* set ft=nginx
augroup END

" Enable syntastic syntax checking
let g:syntastic_enable_signs   = 1
let g:syntastic_quiet_warnings = 1

" Turn off jslint errors by default
let g:JSLintHighlightErrorLine = 0

" Powerline
let g:Powerline_symbols       = 'fancy'
let g:Powerline_cache_enabled = 0
" let g:Powerline_theme         = 'skwp'
" let g:Powerline_colorscheme   = 'skwp'

" Stop fucking netrw
let g:netrw_silent = 1
let g:netrw_quiet  = 1
let g:loaded_netrw = 1

" NERDTree configuration
let NERDTreeQuitOnOpen  = 0   " don't collapse NERDTree when a file is opened
let NERDTreeMinimalUI   = 1
let NERDTreeDirArrows   = 0
let NERDTreeChDirMode   = 2
let NERDTreeIgnore      = ['\.pyc$', '\.rbc$', '\~$']
let NERDTreeHijackNetrw = 0
let g:nerdtree_tabs_startup_cd=1
let g:nerdtree_tabs_open_on_console_startup=1
ca cd NERDTree

" Macvim from here
let macvim_hig_shift_movement = 1

" Shortcuts
imap <C-w> <Esc><C-w> " move through windows in insert mode
imap <C-v> <Esc><C-v> " allow block selection in insert mode

" Keep visual mode during indenting
vmap > >gv
vmap < <gv

" Tab movements & creation
map <C-S-Left> gT
map <C-S-Right> gt
imap <C-S-Left> <ESC>gT
imap <C-S-Right> <ESC>gt

" Resize windows with arrow keys
" nnoremap <D-Up> <C-w>+
nnoremap <D-Down> <C-w>-
nnoremap <D-Left> <C-w><
nnoremap <D-Right>  <C-w>>

" Some personal shortcuts
map gc :!git add . && git commit -a && git push<CR>
map zz :ZoomWin<CR>
map gs :Gstatus<CR>
map gd :Gdiff<CR>
map gp :Git push<CR>
map rr :redraw! \| :NERDTree<CR>
map cc :nohlsearch<CR>
map tt :NERDTreeToggle<CR>
map tb :TagbarToggle<CR>
nmap <leader>ff ggVG=         " format the entire file
nmap <leader>i :set list!<CR> " toggle [i]nvisible characters

" Map the arrow keys to be based on display lines, not physical lines
nmap <Down> gj
nmap <Up> gk
vmap <Down> gj
vmap <Up> gk
" This slow down mvim
" imap <Down> <C-o>gj
" imap <Up> <C-o>gk

" CtrlP
" Additional mapping for buffer search
nmap <leader>t :CtrlPBufferTag<CR>

" Use :W! to write to a file using sudo if you forgot to 'sudo vim file'
cmap W! %!sudo tee > /dev/null %
