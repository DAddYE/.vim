set nocompatible
set nospell
set number
set ruler
" set nocursorcolumn
" set nocursorline
set encoding=utf-8

syntax on

" Whitespace stuff
set nowrap
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

" List chars
set listchars=""                  " Reset the listchars
set listchars=tab:\ \             " a tab should display as "  ", trailing whitespace as "."
set listchars+=trail:.            " show trailing spaces as dots
set listchars+=extends:>          " The character to show in the last column when wrap is
                                  " off and the line continues beyond the right of the screen
set listchars+=precedes:<         " The character to show in the last column when wrap is
                                  " off and the line continues beyond the right of the screen
" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

" Tab completion
set wildmode=list:longest,list:full

" Disable output and VCS files
set wildignore+=*.o,*.out,*.obj,.git,*.rbc,*.class,.svn,*.gem

" Disable archive files
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz

" Ignore bundler and sass cache
set wildignore+=*/vendor/gems/*,*/vendor/cache/*,*/.bundle/*,*/.sass-cache/*

" Disable temp and backup files
set wildignore+=*.swp,*~,._*

"" Backup and swap files

set backupdir=~/.vim/backup/ " where to put backup files.
set directory=~/.vim/tmp/    " where to put swap files.

" Status bar
set laststatus=2

" Clipboard
set clipboard=unnamed

" Mouse
set mouse=a

" Title
set title

" NERDTree configuration
let NERDTreeQuitOnOpen=0   " don't collapse NERDTree when a file is opened
let NERDTreeMinimalUI=1
let NERDTreeDirArrows=0
let NERDTreeChDirMode=2
let NERDTreeIgnore=['\.pyc$', '\.rbc$', '\~$']
let NERDTreeHijackNetrw=0
map <Leader>n :NERDTreeToggle<CR>
autocmd vimenter * if !argc() | NERDTree | endif

" Taskspaper
let g:task_paper_date_format = "%d/%m/%y %H:%M"

" Ctrlp
let g:ctrlp_working_path_mode = 0

" Remember last location in file, but not for commit messages.
" see :help last-position-jump
au BufReadPost * if &filetype !~ '^git\c' && line("'\"") > 0 && line("'\"") <= line("$")
  \| exe "normal! g`\"" | endif

" make uses real tabs
au FileType make set noexpandtab

" Thorfile, Rakefile, GuardFile, Vagrantfile and Gemfile are Ruby
au BufRead,BufNewFile {Gemfile,Rakefile,Guardfile,Vagrantfile,Thorfile,Do,dorc,Dofile,config.ru} set ft=ruby

" add json syntax highlighting
au BufNewFile,BufRead *.json set ft=javascript

" make Python follow PEP8 ( http://www.python.org/dev/peps/pep-0008/ )
au FileType python set softtabstop=4 tabstop=4 shiftwidth=4 textwidth=79

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" load the plugin and indent settings for the detected filetype
filetype plugin indent on

" Enable syntastic syntax checking
let g:syntastic_enable_signs=1
let g:syntastic_quiet_warnings=1

" Use modeline overrides
set modeline
set modelines=10

" Colors
set background=dark
colorscheme pong

" Set fonts
set guioptions=aAce
set guifont=Inconsolata:h13

" Turn off jslint errors by default
let g:JSLintHighlightErrorLine = 0

" % to bounce from do to end etc.
runtime! macros/matchit.vim

" Show (partial) command in the status line
set showcmd

" Minitest autocompletion
set completefunc=syntaxcomplete#Complete

" Shortcuts
imap <C-w> <Esc><C-w>
imap <C-v> <Esc><C-v>
imap <C-y> <Esc><C-y>i
map <C-e> <Esc><C-e>i
map <C-h> gT
map <C-l> gt
nnoremap . :
map gc :!git add . && git commit -a && git push<CR>
map bb :!bash --login<CR>
map gs :Gstatus<CR>
map gp :Git push<CR>
map rr :redraw!<CR>
nmap <Leader>c :nohlsearch<CR>
" cmap w!! w !sudo tee % >/dev/null " Allow to edit file with sudo

" Load custom NERDTree functions
" source ~/.vim/treerc
