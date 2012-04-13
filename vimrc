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
set listchars=tab:▸\ ,trail:·
set lazyredraw
set matchtime=3
set showbreak=↪
set splitbelow
set splitright
set fillchars=vert:\ " nicer on our term
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

set backupdir=~/.vim/tmp/backup/      " where to put backup files.
set directory=~/.vim/tmp/swap/        " where to put swap files.
set backupskip=/tmp/*,/private/tmp/*  " make Vim able to edit crontab files again.
set backup                            " enable backups
set noswapfile                        " It's 2012, Vim.
" set undodir=~/.vim/undo/

set nostartofline " Don’t reset cursor to start of line when moving around.
set esckeys " Allow cursor keys in insert mode
set ttyfast " Optimize for fast terminal connections
set isk+=_,$,@,%,#,- " none word dividers

" Time out on key codes but not mappings.
" Basically this makes terminal Vim work sanely.
set notimeout
set ttimeout
set ttimeoutlen=10

" Colors & C.
set background=dark
colorscheme tomorrow

" Make bolds match gui version
hi Statement  cterm=bold
hi Type       cterm=bold


" let g:solarized_termtrans=1
" let g:solarized_termcolors=256
" let g:solarized_contrast="high"
" let g:solarized_visibility="high"
" colorscheme solarized

filetype plugin indent on      " load the plugin and indent settings for the detected filetype
" runtime! macros/matchit.vim  " % to bounce from do to end etc.

" Change mapleader
let mapleader=","

" Verical bar in insert mode
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

" NERDTree configuration
let NERDTreeQuitOnOpen=0   " don't collapse NERDTree when a file is opened
let NERDTreeMinimalUI=1
let NERDTreeDirArrows=0
let NERDTreeChDirMode=2
let NERDTreeIgnore=['\.pyc$', '\.rbc$', '\~$']
let NERDTreeHijackNetrw=1
map <Leader>n :NERDTreeToggle<CR>
au vimenter * if !argc() | NERDTree | endif

" Save when losing focus
au FocusLost * :silent! wall
"
" Resize splits when the window is resized
au VimResized * :wincmd =

" Taskspaper
let g:task_paper_date_format = "%d/%m/%y %H:%M"

" Ctrlp
let g:ctrlp_working_path_mode = 0

" remember last location in file, but not for commit messages.
au BufReadPost * if &filetype !~ '^git\c' && line("'\"") > 0 && line("'\"") <= line("$")
      \| exe "normal! g`\"" | endif

" make uses real tabs
au FileType make set noexpandtab
au FileType * set expandtab

" Thorfile, Rakefile, GuardFile, Vagrantfile and Gemfile are Ruby
au BufRead,BufNewFile {Gemfile,Rakefile,Guardfile,Vagrantfile,Thorfile,Do,dorc,Dofile,config.ru} set ft=ruby

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
let g:syntastic_enable_signs   =1
let g:syntastic_quiet_warnings =1

" Turn off jslint errors by default
let g:JSLintHighlightErrorLine = 0

" Powerline
let g:Powerline_symbols = 'fancy'
" NERDTree configuration
" autocmd vimenter * if !argc() | NERDTree | endif
augroup AuNERDTreeCmd
  au VimEnter    * call s:CdIfDirectory(expand("<amatch>"))
  au FocusGained * call s:UpdateNERDTree()
augroup END

" If the parameter is a directory, cd into it
function s:CdIfDirectory(directory)
  let explicitDirectory = isdirectory(a:directory)
  let directory = explicitDirectory || empty(a:directory)

  if explicitDirectory
    exe "cd " . fnameescape(a:directory)
  endif

  " Allows reading from stdin
  " ex: git diff | mvim -R -
  if strlen(a:directory) == 0
    return
  endif

  if directory
    NERDTree
    wincmd p
    bd
  endif

  if explicitDirectory
    wincmd p
  endif
endfunction

" NERDTree utility function
function s:UpdateNERDTree(...)
  let stay = 0

  if(exists("a:1"))
    let stay = a:1
  end

  if exists("t:NERDTreeBufName")
    let nr = bufwinnr(t:NERDTreeBufName)
    if nr != -1
      exe nr . "wincmd w"
      exe substitute(mapcheck("R"), "<CR>", "", "")
      if !stay
        wincmd p
      end
    endif
  endif
endfunction

" Shortcuts
imap <C-w> <Esc><C-w> " move through windows in insert mode
imap <C-v> <Esc><C-v> " allow block selection in insert mode

" Keep visual mode during indenting
vmap > >gv
vmap < <gv

" Tab movements & creation
map <C-S-Left> gT
map <C-S-Right> gt
map <C-t> :tabe<CR>

" Some personal shortcuts
map gc :!git add . && git commit -a && git push<CR>
map zz :ZoomWin<CR>
map gs :Gstatus<CR>
map gd :Gdiff<CR>
map gp :Git push<CR>
map rr :redraw! \| :NERDTree<CR>
map cc :nohlsearch<CR>
map tt :NERDTreeToggle<CR>
map rt :TagbarToggle<CR>
nmap <leader>ff ggVG=          " format the entire file
nmap <leader>i :set list!<cr> " toggle [i]nvisible characters

" Map the arrow keys to be based on display lines, not physical lines
nmap <Down> gj
nmap <Up> gk
vmap <Down> gj
vmap <Up> gk
" This slow down mvim
" imap <Down> <C-o>gj
" imap <Up> <C-o>gk

" Use :W!! to write to a file using sudo if you forgot to 'sudo vim file'
cmap W!! %!sudo tee > /dev/null %
