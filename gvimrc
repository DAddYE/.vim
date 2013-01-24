set anti
set guioptions=gemc " egmrt
set guifont=Source\ Code\ Pro\ for\ Powerline:h12
set vb

" NerdTree Tabs
let g:nerdtree_tabs_open_on_gui_startup=0

" Colors & C.
" colorscheme soda

" set transparency=5

" Remap tabs
macmenu &File.New\ Tab key=<D-t>
macmenu &File.Open\ Tab\.\.\. key=<D-^>

" Command-Return for fullscreen
macmenu Window.Toggle\ Full\ Screen\ Mode key=<D-CR>

" Next and previous tab
macmenu Window.Select\ Next\ Tab Key=<S-D-Right>
macmenu Window.Select\ Previous\ Tab key=<S-D-Left>

" CTRLP Mappings
macmenu &File.Print key=<D-M-p>
map <D-p> :CtrlP<CR>
imap <D-p> <ESC>:CtrlP<CR>
map <D-P> :CtrlPBuffer<CR>
imap <D-P> <ESC>:CtrlPBuffer<CR>

" Bubble single lines
nmap <D-Up> [e
nmap <D-Down> ]e
nmap <D-k> [e
nmap <D-j> ]e

" Bubble multiple lines
vmap <D-Up> [egv
vmap <D-Down> ]egv
vmap <D-k> [egv
vmap <D-j> ]egv

" Resize windows with arrow keys
" nnoremap <D-Up> <C-w>+
" nnoremap <D-Down> <C-w>-
" nnoremap <D-Left> <C-w><
" nnoremap <D-Right>  <C-w>>

" Command-Shift-F for Ack
map <D-F> :Ack<space>

" Map command-[ and command-] to indenting or outdenting
" while keeping the original selection in visual mode
vmap <D-]> >gv
vmap <D-[> <gv

nmap <D-]> >>
nmap <D-[> <<

omap <D-]> >>
omap <D-[> <<

imap <D-]> <Esc>>>i
imap <D-[> <Esc><<i

" Map Command-# to switch tabs
map  <D-0> 0gt
imap <D-0> <Esc>0gt
map  <D-1> 1gt
imap <D-1> <Esc>1gt
map  <D-2> 2gt
imap <D-2> <Esc>2gt
map  <D-3> 3gt
imap <D-3> <Esc>3gt
map  <D-4> 4gt
imap <D-4> <Esc>4gt
map  <D-5> 5gt
imap <D-5> <Esc>5gt
map  <D-6> 6gt
imap <D-6> <Esc>6gt
map  <D-7> 7gt
imap <D-7> <Esc>7gt
map  <D-8> 8gt
imap <D-8> <Esc>8gt
map  <D-9> 9gt
imap <D-9> <Esc>9gt

" Command-Option-ArrowKey to switch viewports
map <D-M-Up> <C-w>k
imap <D-M-Up> <Esc> <C-w>k
map <D-M-Down> <C-w>j
imap <D-M-Down> <Esc> <C-w>j
map <D-M-Right> <C-w>l
imap <D-M-Right> <Esc> <C-w>l
map <D-M-Left> <C-w>h
imap <D-M-Left> <C-w>h

" Adjust viewports to the same size
map <Leader>= <C-w>=
imap <Leader>= <Esc> <C-w>=
