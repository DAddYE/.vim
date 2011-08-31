set nocompatible
set spell
set number
set ruler
syntax on

" Set encoding
set encoding=utf-8

" Whitespace stuff
set nowrap
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set list listchars=tab:\ \ ,trail:·

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

" Tab completion
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,vendor/gems/*

" Status bar
set laststatus=2

" Clipboard
set clipboard=unnamed

" Mouse
set mouse=a

" Without setting this, ZoomWin restores windows in a way that causes
" equalalways behavior to be triggered the next time CommandT is used.
" This is likely a bludgeon to solve some other issue, but it works
set noequalalways

" NERDTree configuration
let NERDTreeQuitOnOpen=0   " don't collapse NERDTree when a file is opened
let NERDTreeMinimalUI=1    " YAGNI
let NERDTreeChDirMode=2
let NERDTreeIgnore=['\.pyc$', '\.rbc$', '\~$']
let NERDTreeHijackNetrw=0
map <Leader>n :NERDTreeToggle<CR>

" ZoomWin configuration
map <Leader><Leader> :ZoomWin<CR>

" Remember last location in file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif

function s:setupWrapping()
  set wrap
  set wrapmargin=2
  set textwidth=72
endfunction

" make uses real tabs
au FileType make set noexpandtab

" Thorfile, Rakefile, GuardFile, Vagrantfile and Gemfile are Ruby
au BufRead,BufNewFile {Gemfile,Rakefile,Guardfile,Vagrantfile,Thorfile,Do,dorc,Dofile,config.ru} set ft=ruby

" add json syntax highlighting
au BufNewFile,BufRead *.json set ft=javascript

au BufRead,BufNewFile *.txt call s:setupWrapping()

" make Python follow PEP8 ( http://www.python.org/dev/peps/pep-0008/ )
au FileType python set softtabstop=4 tabstop=4 shiftwidth=4 textwidth=79

" autocmd
au BufWritePost *_spec.rb :! rspec %
au BufWritePost *.coffee :!coffee --bare -o public/javascripts -c %

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" load the plugin and indent settings for the detected filetype
filetype plugin indent on

" Opens an edit command with the path of the currently edited file filled in
" Normal mode: <Leader>e
map <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" Inserts the path of the currently edited file into a command
" Command mode: Ctrl+P
cmap <C-P> <C-R>=expand("%:p:h") . "/" <CR>

" Enable syntastic syntax checking
let g:syntastic_enable_signs=1
let g:syntastic_quiet_warnings=1

" Quickfix crontab
" remember to add:
"   alias crontab="VIM_CRONTAB=true crontab"
" in ~/.bash_profile
if $VIM_CRONTAB == "true"
  set nobackup
  set nowritebackup
endif

" Gist-vim defaults
if has("mac")
  let g:gist_clip_command = 'pbcopy'
elseif has("unix")
  let g:gist_clip_command = 'xclip -selection clipboard'
endif
let g:gist_detect_filetype = 1
let g:gist_open_browser_after_post = 1

" Use modeline overrides
set modeline
set modelines=10

" Default color scheme
colorscheme solarized

" Set fonts
set guioptions=aAce
set guifont=Menlo:h13

" Directories for swp files
set backupdir=~/.vim/backup
set directory=~/.vim/backup

" Turn off jslint errors by default
let g:JSLintHighlightErrorLine = 0

" % to bounce from do to end etc.
runtime! macros/matchit.vim

" Show (partial) command in the status line
set showcmd

" Custom shortcuts
imap <C-w> <Esc><C-w>
imap <C-v> <Esc><C-v>
imap <C-y> <Esc><C-y>i
imap <C-e> <Esc><C-e>i
imap <C-t> <Esc>:CommandT<CR>
map <C-t> :CommandT<CR>
map <C-h> gT
map <C-l> gt
nmap <Leader>vi :tabe $MYVIMRC<CR>

" Fold
set foldmethod=syntax
set nofoldenable

" Custom Leaders
nmap <Leader>g :!git add . && git commit -a && git push<CR>
nmap <Leader>b :!bash --login<CR>
nmap <Leader>gs :Gstatus<CR>
nmap <Leader>gp :Git push<CR>

" Load custom NERDTree functions
source ~/.vim/treerc
