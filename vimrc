set nocompatible
syntax on
set nospell
set number
set nocursorcolumn
set nocursorline
set encoding=utf-8
set title
set shortmess=atI " don't sho intro messages
set report=0      " tell us about changes
set backspace=indent,eol,start " allow backspacing over everything in insert mode
set nowrap
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set ruler
set list listchars=tab:\ \ ,trail:·
set hlsearch
set incsearch
set ignorecase
set smartcase
set laststatus=2
set clipboard+=unnamed
set mouse=a
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
set backupdir=~/.vim/backup/ " where to put backup files.
set directory=~/.vim/tmp/    " where to put swap files.
" set undodir=~/.vim/undo/
set nostartofline " Don’t reset cursor to start of line when moving around.
set esckeys " Allow cursor keys in insert mode
set ttyfast " Optimize for fast terminal connections
set isk+=_,$,@,%,#,- " none word dividers

" Colors & C.
set background=dark         " Assume a dark background
colorscheme tomorrow

" Make bolds match gui version
hi Statement	cterm=bold
hi Type       cterm=bold


" let g:solarized_termtrans=1
" let g:solarized_termcolors=256
" let g:solarized_contrast="high"
" let g:solarized_visibility="high"
" colorscheme solarized

filetype plugin indent on      " load the plugin and indent settings for the detected filetype
" runtime! macros/matchit.vim    " % to bounce from do to end etc.

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

" Enable syntastic syntax checking
let g:syntastic_enable_signs=1
let g:syntastic_quiet_warnings=1

" Turn off jslint errors by default
let g:JSLintHighlightErrorLine = 0

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
vmap > >gv
vmap < <gv
map <Leader>n :NERDTreeToggle<CR>
map <C-e> <Esc><C-e>i
map <C-S-Left> gT
map <C-S-Right> gt
map <C-t> :tabe<CR>
map gc :!git add . && git commit -a && git push<CR>
map zz :ZoomWin<CR>
map gs :Gstatus<CR>
map gp :Git push<CR>
map rr :redraw! \| :NERDTree<CR>
nmap <Leader>c :nohlsearch<CR>

" format the entire file
nmap <leader>fef ggVG=

" Map the arrow keys to be based on display lines, not physical lines
nnoremap <Down> gj
nnoremap <Up> gk
vnoremap <Down> gj
vnoremap <Up> gk
" inoremap <Down> <C-o>gj
" inoremap <Up> <C-o>gk

" do not menu with left / right in command line
" cnoremap <Left> <Space><BS><Left>
" cnoremap <Right> <Space><BS><Right>

" Tagbar
map <Leader>rt :TagbarToggle<CR>
map rt :TagbarToggle<CR>

" Replace currently selected text with default register
" without yanking it
" vnoremap p "_dp
" use :w!! to write to a file using sudo if you forgot to 'sudo vim file'
" (it will prompt for sudo password when writing)
cmap W!! %!sudo tee > /dev/null %
