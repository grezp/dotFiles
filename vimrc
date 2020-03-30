"----------------------------"
"---GENERAL CONFIG OPTIONS---"
"----------------------------"
""""""""""""""""""""""""""""""

set nowrap                  " no wrapping to next line
set tabstop=4               " set tab space to 4
set expandtab               " expand tabs to spaces
set foldmethod=syntax       " fold all code
set shiftwidth=4            " shift block width
set scrolloff=2             " leave lines above & below cursor
set hidden                  " prevent abondoning changes when buf is changed
set noswapfile              " prevent vim from creating swap files
set showcmd                 " show keys pressed in cmd line
set laststatus=2            " always show status bar
set tabline=1               " shows # of tab lines
set noshowmode              " hides the mode (eg. insert, visual)
set t_Co=256                " number of colors
set encoding=utf-8
colorscheme desert
hi IncSearch term=NONE ctermfg=Black ctermbg=Cyan  
hi Search cterm=NONE ctermfg=black ctermbg=yellow

"____________________"
"___PATTERN SEARCH___"
set hlsearch                " high light search patterns
set incsearch               " find patter as you type
set ignorecase              " ignore case when searching
set smartcase               " stop ignorecase when searching w/ caps

"____________________"
"___CURSOR OPTIONS___"
let &t_SI = "\<Esc>]50;CursorShape=1\x7"        " insert mode cursor
"let &t_SR = "\<Esc>]50;CursorShape=2\x7"        " replace mode cursor
let &t_EI = "\<Esc>]50;CursorShape=0\x7"        " switch back to block cursor
set cursorline                                  " cursor highlight on start
hi CursorLine ctermbg=236 cterm=bold|           " cursor highlight color


""""""""""""""""""""
"------------------"
"---GENERAL MAPS---"
"------------------"
""""""""""""""""""""

"_____________"
"___GENERAL___"
map <Space> <Leader>|                       " make space leader key
noremap <Leader>o o<Esc>|                   " enter new line below & gt normal
noremap <Leader>O O<Esc>|                   " enter new line above & gt normal
nnoremap <Leader>, :noh<CR>|                " stops highlight from search
noremap <Leader>m :set cursorline!<CR>      " toggle cursor line

"__________"
"___TABS___"
noremap <silent> <Leader>tn :tabnew<CR>|        " open new tab
noremap <silent> <Leader>tc :tabclose<CR>|      " closes current tab
noremap <silent> <Leader>to :tabonly<CR>|       " closes all tabs except current
noremap <silent> <Leader>tk :tabnext<CR>|       " move to next tab
noremap <silent> <Leader>tj :tabprev<CR>|       " move to prev tab
noremap <Leader>t1 1gt|                         " change to tab #
noremap <Leader>t2 2gt|                         " change to tab #
noremap <Leader>t3 3gt|                         " change to tab #
noremap <Leader>t4 4gt|                         " change to tab #
noremap <Leader>t5 5gt|                         " change to tab #
noremap <Leader>t6 6gt|                         " change to tab #
noremap <Leader>t7 7gt|                         " change to tab #
noremap <Leader>t8 8gt|                         " change to tab #
noremap <Leader>t9 9gt|                         " change to tab #

"_____________"
"___BUFFERS___"
set winheight=6
set winminheight=6                          " smallest window possible
map <Leader>w <C-w>|                        " window keybind
nnoremap <C-w>+ <C-w>=|                     " swap window same-height & increase
nnoremap <leader>bd :bd<CR>|                " delete current buffer
nmap <Leader>bk :bnext<CR>|                 " move to next buffer
nmap <Leader>bj :bprev<CR>|                 " move to prev buffer
nmap <Leader>1 <Plug>AirlineSelectTab1      " change to buffer #
nmap <Leader>2 <Plug>AirlineSelectTab2      " change to buffer #
nmap <Leader>3 <Plug>AirlineSelectTab3      " change to buffer #
nmap <Leader>4 <Plug>AirlineSelectTab4      " change to buffer #
nmap <Leader>5 <Plug>AirlineSelectTab5      " change to buffer #
nmap <Leader>6 <Plug>AirlineSelectTab6      " change to buffer #
nmap <Leader>7 <Plug>AirlineSelectTab7      " change to buffer #
nmap <Leader>8 <Plug>AirlineSelectTab8      " change to buffer #
nmap <Leader>9 <Plug>AirlineSelectTab9      " change to buffer #

"_____________________"
"___SCROLL/POSITION___"
nnoremap <C-j> <C-e>|           " scroll down
nnoremap <C-k> <C-y>|           " scroll up
nnoremap <C-l> zl|              " scroll left
nnoremap <C-h> zh|              " scroll right
nnoremap <Leader><C-j> <C-d>|   " half page down
nnoremap <Leader><C-k> <C-u>|   " half page up
nnoremap <Leader><C-l> zL|      " half page left
nnoremap <Leader><C-h> zH|      " half page right
nnoremap zj zb|                 " move window @ bottom cursor line
nnoremap zk zt|                 " move window @ top cursor line

"_________________"
"___SYSTEM FILE___"
nnoremap <Leader>s :w<CR>|               " saves current file
nnoremap <Leader>q :q<CR>|               " exit window
nnoremap <Leader>Q :q!<CR>|              " exit window w/o saving


"""""""""""""""
"-------------"
"---PLUGINS---"
"-------------"
"""""""""""""""

"______________"
"___VIM.PLUG___"
silent! call plug#begin()
    Plug 'git/git'
    Plug 'scrooloose/nerdtree'                      " file system explorer
    Plug 'scrooloose/nerdcommenter'                 " comment code easily
    Plug 'vim-airline/vim-airline'                  " improves status bar
    Plug 'vim-airline/vim-airline-themes'           " themes for airline
    Plug 'powerline/fonts'                          " fonts needed for airline symbols
    Plug 'junegunn/fzf'                             " command line fuzzy finder
    Plug 'junegunn/fzf.vim'                         " fzf embeded into vim
    Plug 'kana/vim-submode'                         " repeat cmd's with a single press
    Plug 'tpope/vim-fugitive'                       " git wrapper for vim
    "Plug 'vim-syntastic/syntastic'
call plug#end()


"______________"
"___NERDTREE___"
map <Leader>n :NERDTreeToggle<CR>
map <Leader>f :NERDTreeFind
let NERDTreeShowLineNumbers = 1
let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '~'

"_____________"
"___AIRLINE___"
let g:airline_theme='bubblegum'                                 " select theme
let g:airline_powerline_fonts = 0                               " enables powerline fonts
let g:airline#extensions#tabline#enabled = 1                    " enable tabline
let g:airline#extensions#tabline#buf_label_first = 1            " place buffers on the left
let g:airline#extensions#tabline#show_tabs = 0                  " disable tabs from being shown
let g:airline#extensions#tabline#fnamemod = ':t'                " display filename only & not pwd
let g:airline#extensions#tabline#buffer_idx_mode = 1            " show buffer tab index not b#
let g:airline#extensions#tabline#buffers_label = 'Buffers'      " display buffer label
let g:airline#extensions#tabline#buffer_idx_format = {
                                                     \ '0': '0 ',
                                                     \ '1': '1 ',
                                                     \ '2': '2 ',
                                                     \ '3': '3 ',
                                                     \ '4': '4 ',
                                                     \ '5': '5 ',
                                                     \ '6': '6 ',
                                                     \ '7': '7 ',
                                                     \ '8': '8 ',
                                                     \ '9': '9 '
                                                     \ }
let g:airline_mode_map = {
                         \ '__' : '------',
                         \ 'n'  : 'Normal',
                         \ 'i'  : 'Insert',
                         \ 'R'  : 'Replace',
                         \ 'v'  : 'Visual',
                         \ 'V'  : 'V-Line',
                         \ 'c'  : 'Command',
                         \ '^V' : 'V-Block',
                         \ 's'  : 'Select',
                         \ 'S'  : 'S-Line',
                         \ '^S' : 'S-Block',
                         \ 't'  : 'Terminal',
                         \ }

function! AirlineInit()
  let g:airline_section_a = airline#section#create(['mode', ' ', 'branch'])
  let g:airline_section_b = airline#section#create_left(['path', 'readonly'])
  let g:airline_section_c = ""
  let g:airline_section_z = airline#section#create_right(['%l ', '%L ☰', '%p%%'])
"  let g:airline_section_z = airline#section#create_right(['%l ', '%L ☰', '%v ‖', '%p%%'])
endfunction
autocmd User AirlineAfterInit call AirlineInit()

"________________"
"___BUFFERLINE___"
"let g:bufferline_echo = 0                       " remove buffers from cmd line
"let g:bufferline_modified = '+'                 " symbol to denote buffer is mod.
"let g:bufferline_fname_mod = ':t'               " only includes the file name
"let g:bufferline_solo_highlight = 1             " highlight when only 1 buffer

"_____________"
"___SUBMODE___"
let g:submode_timeout = 0                   " disable timeouts
let g:submode_keep_leaving_key = 1          " external cmd executes and exits submode

call submode#enter_with('undo/redo', 'n', '', 'g-', 'g-')                                 " undo by pressing g-
call submode#enter_with('undo/redo', 'n', '', 'g=', 'g+')                                 " redo by pressing g-
call submode#map('undo/redo', 'n', '', '-', 'g-')                                         " undo by repeat   -
call submode#map('undo/redo', 'n', '', '=', 'g+')                                         " redo by repeat   +

call submode#enter_with('buffHeight', 'n', 's', '<C-w>=', ':exe "resize +6"<CR>')         " inc height by pressing <C-w> =
call submode#enter_with('buffHeight', 'n', 's', '<C-w>-', ':exe "resize -6"<CR>')         " dec height by pressing <C-w> -
call submode#map('buffHeight', 'n', 's', '=', ':exe "resize +6"<CR>')                     " inc height by repeat    =
call submode#map('buffHeight', 'n', 's', '-', ':exe "resize -6"<CR>')                     " dec height by repeat    -

call submode#enter_with('buffWidth', 'n', 's', '<C-w>>', ':exe "vert resize +6"<CR>')     " inc width by pressing <C-w> >
call submode#enter_with('buffWidth', 'n', 's', '<C-w><', ':exe "vert resize -6"<CR>')     " dec width by pressing <C-w> <
call submode#map('buffWidth', 'n', 's', '>', ':exe "vert resize +6"<CR>')                 " inc width by repeat    >
call submode#map('buffWidth', 'n', 's', '<', ':exe "vert resize -6"<CR>')                 " dec width by repeat    <
call submode#map('buffWidth', 'n', 's', '.', ':exe "vert resize +6"<CR>')                 " inc width by repeat    .
call submode#map('buffWidth', 'n', 's', ',', ':exe "vert resize -6"<CR>')                 " dec width by repeat    ,

call submode#enter_with('chTab', 'n', '', '<Leader>tk', ':tabnext<CR>')                   " next tab by pressing <Leader><tk
call submode#enter_with('chTab', 'n', '', '<Leader>tj', ':tabprev<CR>')                   " prev tab by pressing <Leader><tj
call submode#map('chTab', 'n', '', 'k', ':tabnext<CR>')                                   " next tab by repeat    k
call submode#map('chTab', 'n', '', 'j', ':tabprev<CR>')                                   " prev tab by repeat    j

call submode#enter_with('chBuff', 'n', '', '<Leader>bk', ':bnext<CR>')                    " next buffer by pressing <Leader><bk
call submode#enter_with('chBuff', 'n', '', '<Leader>bj', ':bprev<CR>')                    " prev buffer by pressing <Leader><bj
call submode#map('chBuff', 'n', '', 'k', ':bnext<CR>')                                    " next buffer by repeat    k
call submode#map('chBuff', 'n', '', 'j', ':bprev<CR>')                                    " prev buffer by repeat    j

call submode#enter_with('scrolling', 'n', '', '<C-j>', '<C-e><C-e>')                      " scroll down  by pressing <C-j> x2
call submode#enter_with('scrolling', 'n', '', '<C-k>', '<C-y><C-y>')                      " scroll up    by pressing <C-k> x2
call submode#enter_with('scrolling', 'n', '', '<C-l>', 'zlzlzlzl')                        " scroll right by pressing <C-l> x4
call submode#enter_with('scrolling', 'n', '', '<C-h>', 'zhzhzhzh')                        " scroll left  by pressing <C-h> x4
call submode#map('scrolling', 'n', '', 'j', '<C-e><C-e>')                                 " scroll down  by repeat    j    x2
call submode#map('scrolling', 'n', '', 'k', '<C-y><C-y>')                                 " scroll up    by repeat    k    x2
call submode#map('scrolling', 'n', '', 'l', 'zlzlzlzl')                                   " scroll right by repeat    l    x4
call submode#map('scrolling', 'n', '', 'h', 'zhzhzhzh')                                   " scroll left  by repeat    h    x4

call submode#enter_with('halfPage', 'n', '', '<Leader><C-j>', '<C-e>')                    " half pg down  by pressing <Leader><C-j>
call submode#enter_with('halfPage', 'n', '', '<Leader><C-k>', '<C-y>')                    " half pg up    by pressing <Leader><C-k>
call submode#enter_with('halfPage', 'n', '', '<Leader><C-l>', 'zl')                       " half pg right by pressing <Leader><C-l>
call submode#enter_with('halfPage', 'n', '', '<Leader><C-h>', 'zh')                       " half pg left  by pressing <Leader><C-h>
call submode#map('halfPage', 'n', '', '<C-j>', '<C-d>')                                   " half pg down  by repeat   <C-j>
call submode#map('halfPage', 'n', '', '<C-k>', '<C-u>')                                   " half pg up    by repeat   <C-k>
call submode#map('halfPage', 'n', '', '<C-l>', 'zL')                                      " half pg right by repeat   <C-l>
call submode#map('halfPage', 'n', '', '<C-h>', 'zH')                                      " half pg left  by repeat   <C-h>
call submode#map('halfPage', 'n', '', 'j', '<C-d>')                                       " half pg down  by repeat    j
call submode#map('halfPage', 'n', '', 'k', '<C-u>')                                       " half pg up    by repeat    k
call submode#map('halfPage', 'n', '', 'l', 'zL')                                          " half pg right by repeat    l
call submode#map('halfPage', 'n', '', 'h', 'zH')                                          " half pg left  by repeat    h


"""""""""""""""""
"---------------"
"---FUNCTIONS---"
"---------------"
"""""""""""""""""

" removes relative number line when not focused
:set number relativenumber
:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber            " relative nr when focused
:  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber          " normal nw when not focused
:augroup END

" removes highlight cursor when not focused
:augroup cursorFocus
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave * set cursorline                " cursor highlight when focused
:  autocmd BufLeave,FocusLost,InsertEnter   * set nocursorline              " no cursor when not focused
:augroup END
