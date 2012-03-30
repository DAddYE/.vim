set nocompatible
set nospell
set number
set ruler
set nocursorcolumn
set nocursorline
set encoding=utf-8

syntax on

" Whitespace stuff
set nowrap
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

" List chars
" set list listchars=trail:·,tab:››
set list listchars=tab:\ \ ,trail:·

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
let NERDTreeHijackNetrw=1
map <Leader>n :NERDTreeToggle<CR>
autocmd vimenter * if !argc() | NERDTree | endif
autocmd BufLeave,FocusLost * silent! wall

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
" set background=light
" let g:solarized_hitrail=1    "default value is 0
" let g:solarized_termcolors=256
" let g:solarized_degrade=1
let g:solarized_termtrans=1
" let g:molokai_original=1
colorscheme solarized

" Set fonts
" set guioptions=aAce
" set guifont=Inconsolata:h13

" Turn off jslint errors by default
let g:JSLintHighlightErrorLine = 0

" % to bounce from do to end etc.
runtime! macros/matchit.vim

" Show (partial) command in the status line
set showcmd

" Minitest autocompletion
set completefunc=syntaxcomplete#Complete

let NERDTreeQuitOnOpen=0   " don't collapse NERDTree when a file is opened
let NERDTreeMinimalUI=1
let NERDTreeDirArrows=0
let NERDTreeChDirMode=2
let NERDTreeIgnore=['\.pyc$', '\.pyo$', '\.rbc$', '\.rbo$', '\.class$', '\.o$', '\~$']
let NERDTreeHijackNetrw=0

" Save on lost focus
autocmd BufLeave,FocusLost * silent! wall

" Powerline
let g:Powerline_symbols = 'fancy'

" NERDTree configuration
" autocmd vimenter * if !argc() | NERDTree | endif
augroup AuNERDTreeCmd
autocmd AuNERDTreeCmd VimEnter * call s:CdIfDirectory(expand("<amatch>"))
autocmd AuNERDTreeCmd FocusGained * call s:UpdateNERDTree()

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
imap <C-w> <Esc><C-w>
imap <C-v> <Esc><C-v>
imap <C-y> <Esc><C-y>i
map <Leader>n :NERDTreeToggle<CR>
map <C-e> <Esc><C-e>i
map <C-h> gT
map <C-l> gt
map gc :!git add . && git commit -a && git push<CR>
map zz :ZoomWin<CR>
map bb :!bash --login<CR>
map gs :Gstatus<CR>
map gp :Git push<CR>
map rr :redraw! \| :NERDTree<CR>
nmap <Leader>c :nohlsearch<CR>

" format the entire file
nmap <leader>fef ggVG=

" Map the arrow keys to be based on display lines, not physical lines
map <Down> gj
map <Up> gk

" Tagbar
map <Leader>rt :TagbarToggle<CR>
map rt :TagbarToggle<CR>

" Replace currently selected text with default register
" without yanking it
" vnoremap p "_dp
" use :w!! to write to a file using sudo if you forgot to 'sudo vim file'
" (it will prompt for sudo password when writing)
" cmap w!! %!sudo tee > /dev/null %
