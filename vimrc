" vim:fdm=marker

"---BINDINGS TO REMEMBER---"
"--------------------------"
""""""""""""""""""""""""""""

" :set nowrap number relativenumber wildmenu foldmethod=syntax

"_____________________"
"___SCROLL/POSITION___"
"
" ^C-d      half page down
" ^C-u      half page up
" zL        half page left
" zH        half page right
"
" zt        move cursor - window top
" zb        move cursor - window bottom
" zz        move cursor - window middle
"
" ^C-e      single line down
" ^C-y      single line up
" zl        single line left
" zh        single line right

"________________"
"___NAVIGATION___"
"
" m(x)      [m] creates a mark
" '(x)      ['] goes to mark
" f(x)      [f] finds next chard [F] for backwards

"__________"
"___MISC___"
"
" ^C-6      toggle between last 2 buffers
" ^C-r      redo prev cmd - undos undo
" "(#)      ["] stores into reg, used with y/p
" .         repeat prev cmd

"___________________"
"___NERDCOMMENTER___"
" [count]<leader>c<space>        comment toggle
" [count]<leader>cc              comment single line
" [count]<leader>ci              remove single line comment
" [count]<leader>cm              comment minimal block
" [count]<leader>cs              comment sexy block
" <leader>ca                     comment altDelims

"---GENERAL CONFIG OPTIONS---" {{{
"----------------------------"
""""""""""""""""""""""""""""""

"___GENERAL_SETTINGS___" {{{{
"______________________"
set nowrap                  " no wrapping to next line
set tabstop=4               " set tab space to 4
set expandtab               " expand tabs to spaces
set foldmethod=syntax       " fold all code
set shiftwidth=4            " shift block width
set scrolloff=2             " leave lines above & below cursor
set hidden                  " change buffer w/o saving
set noswapfile              " prevent vim from creating swap files
set showcmd                 " show keys pressed in cmd line
set laststatus=2            " always show status bar
set noshowmode              " hides the mode (eg. insert, visual)
set path+=.,**
set wildmenu
set wildignore=*/build/*,*.bak
set tags+=tags,/prj/vlsi/pete/qat3518_cohu/.tmp/.pgutierr/ltx_include/tags;
" }}}

"___COLOR_OPTIONS___" {{{
"___________________"
set termguicolors                               " 24 bit colors
syntax on                                       " Turn on syntax hilighting
colorscheme space-vim-dark                      " http://www.calmar.ws/vim/256-xterm-24bit-rgb-color-chart.html
hi cppOperators gui=none  guifg=#87afff|        " change cpp operator color
hi Folded gui=none guibg=#262626 guifg=#005f5f| " change folding fg & bg color
hi unisonClass gui=none  guifg=#bc6ec5|         " highlight unison Classes
hi unisonDataTypes gui=none  guifg=#5f87d7|     " highlight usision data types
hi unisonTypeDefs gui=none  guifg=#5f87d7|      " hi unison type defs
hi unisonEnums gui=bold  guifg=#5f87d7|         " hi unison enums
" }}}

"___PATTERN SEARCH___" {{{
"____________________"
set hlsearch                " high light search patterns
set incsearch               " find patter as you type
set ignorecase              " ignore case when searching
set smartcase               " stop ignorecase when searching w/ caps
" }}}

""___CURSOR OPTIONS___" {{{
""____________________"
"let &t_SI = "\<Esc>]50;CursorShape=1\x7"        " insert mode cursor
"let &t_SR = "\<Esc>]50;CursorShape=2\x7"        " replace mode cursor
"let &t_EI = "\<Esc>]50;CursorShape=0\x7"        " switch back to block cursor
set cursorline                                  " cursor highlight on start
"hi CursorLine ctermbg=DarkGrey cterm=bold|           " cursor highlight color
" }}}

" }}}

"---GENERAL MAPS---" {{{
"------------------"
""""""""""""""""""""

"___GENERAL___" {{{
"_____________"
map <Space> <Leader>|                       " make space leader key
noremap <Leader>o o<Esc>|                   " enter new line below & gt normal
noremap <Leader>O O<Esc>|                   " enter new line above & gt normal
nnoremap <Leader>, :noh<CR>|                " stops highlight from search
" }}}

"___WINDOWS___" {{{
"_____________"
map <Leader>w <C-w>|                             " window keybind
nnoremap <Leader>w+ 10<C-w>+|                    " inc window height 
nnoremap <Leader>w- 10<C-w>-|                    " dec window height
nnoremap <leader>w> 30<C-w>>|                    " inc > window height 
nnoremap <leader>w< 30<C-w><|                    " inc < window height
" }}}

"___OPENING FILES___" {{{
"___________________"
noremap <Leader>f :find |                   " default find files
" noremap <Leader>ff :find<CR>|                  " default find files
noremap <Leader>F :Files |                  " init fzf search pattern
noremap <Leader>FF :Files<CR>|                 " init fzf search pattern
" }}}

"___BUFFERS___" {{{
"_____________"
nnoremap <Leader>bl :ls<CR>|                " list buffers
nnoremap <Leader>bL :Buffers<CR>|           " fzf buffer
nnoremap <Leader>bd :bd<CR>|                " delete current buffer
nnoremap <Leader>bk :bnext<CR>|             " move to next buffer
nnoremap <Leader>bj :bprev<CR>|             " move to prev buffer
nnoremap <silent> <Leader>b1 :b1<CR>|       " go to buffer #
nnoremap <silent> <Leader>b2 :b2<CR>|       " go to buffer #
nnoremap <silent> <Leader>b3 :b3<CR>|       " go to buffer #
nnoremap <silent> <Leader>b4 :b4<CR>|       " go to buffer #
nnoremap <silent> <Leader>b5 :b5<CR>|       " go to buffer #
nnoremap <silent> <Leader>b6 :b6<CR>|       " go to buffer #
nnoremap <silent> <Leader>b7 :b7<CR>|       " go to buffer #
nnoremap <silent> <Leader>b8 :b8<CR>|       " go to buffer #
nnoremap <silent> <Leader>b9 :b9<CR>|       " go to buffer #
nnoremap <silent> <Leader>b0 :b10<CR>|      " go to buffer #
" }}}

"___SYSTEM FILE___" {{{
"_________________"
nnoremap <Leader>s :w<CR>|               " saves current file
nnoremap <Leader>q :q<CR>|               " exit window
nnoremap <Leader>Q :q!<CR>|              " exit window w/o saving
" }}}

" }}}

"---PLUGINS---" {{{
"-------------"
"""""""""""""""

"___VIM.PLUG___"
silent! call plug#begin()
    Plug 'preservim/nerdtree'                       " browse files/folders
    Plug 'preservim/nerdcommenter'                  " comment code easily
    Plug 'junegunn/fzf'                             " command line fuzzy finder
    Plug 'junegunn/fzf.vim'                         " fzf embeded into vim
    Plug 'tpope/vim-fugitive'                       " git wrapper for vim
    Plug 'ludovicchabant/vim-gutentags'             " ctag manager
call plug#end()

"___NERDTREE___" {{{
"______________"
noremap <Leader>n :NERDTreeToggle<CR>
let NERDTreeShowLineNumbers = 1
let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '~'
" }}}

"___NERDCOMMENTER___" {{{
"___________________"
let g:NERDSpaceDelims = 1 |                 " adds space between comment & char
let g:NERDDefaultAlign = 'left' |           " flush single line comments
let g:NERDCommentEmptyLines = 1 |           " comment empty lines
" }}}

"___FUGITIVE___" {{{
"______________"
noremap <Leader>g :Git! |                   " init Git cmd
noremap <Leader>ga :Git! add |              " init Git add cmd
noremap <Leader>gd :Git! diff |             " init Git diff cmd
noremap <Leader>gs :Git! status<CR>|        " exec Git status cmd
noremap <Leader>gc :Git commit<CR>|         " exec Git commit cmd
noremap <Leader>gl :Git! log<CR>|           " exec Git log cmd
" }}}
" }}}

"---FUNCTIONS---" {{{
"---------------"
"""""""""""""""""

" removes relative number line when not focused " {{{
" --------------------------------------------- "
:set number relativenumber
:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber            " relative nr when focused
:  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber          " normal nw when not focused
:augroup END
" }}}

" removes highlight cursor when not focused " {{{
" ----------------------------------------- "
:augroup cursorFocus
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave * set cursorline                " cursor highlight when focused
:  autocmd BufLeave,FocusLost,InsertEnter   * set nocursorline              " no cursor when not focused
:augroup END
" }}}
" }}}

"---STATUSLINE---" {{{
"------------ ---"
" statusline modes {{{
let g:currentmode={
    \ 'n'      : 'NORMAL',
    \ 'no'     : 'N·Operator Pending',
    \ 'v'      : 'VISUAL',
    \ 'V'      : 'V·LINE',
    \ "\<C-V>" : 'V·BLOCK',
    \ 's'      : 'SELECT',
    \ 'S'      : 'S·LINE',
    \ "\<C-S>" : 'S·BLOCK',
    \ 'i'      : 'INSERT',
    \ 'R'      : 'REPLACE',
    \ 'Rv'     : 'V·REPLACE',
    \ 'c'      : 'COMMAND',
    \ 'cv'     : 'VIM EX',
    \ 'ce'     : 'EX',
    \ 'r'      : 'PROMPT',
    \ 'rm'     : 'MORE',
    \ 'r?'     : 'CONFIRM',
    \ '!'      : 'SHELL',
    \ 't'      : 'TERMINAL'
    \}
" }}}

" FileSize() {{{
" Find out current buffer's size and output it.
function! FileSize()
  let bytes = getfsize(expand('%:p'))
  if (bytes >= 1024)
    let kbytes = bytes / 1024
  endif

  if (exists('kbytes') && kbytes >= 1000)
    let mbytes = kbytes / 1000
  endif

  if bytes <= 0
    return '0'
  endif

  if (exists('mbytes'))
    return mbytes . 'MB '
  elseif (exists('kbytes'))
    return kbytes . 'KB '
  else
    return bytes . 'B '
  endif
endfunction
" }}}

" statusline colors {{{{
hi User1 guifg=#b2b2b2 guibg=#262626            " white
hi User2 guifg=#E697E6 guibg=#262626            " magenta
hi User3 guifg=#20af81 guibg=#262626            " dark green
hi User4 guifg=#74BAAC guibg=#262626            " light green
hi User5 guifg=#4f97d7 guibg=#262626            " blue
hi User6 guifg=#D881ED guibg=#262626            " dark magenta
hi User7 guifg=#262626 guibg=#74BAAC           " light green
" }}}}

let g:status_fileName = expand("%:~ ")
set laststatus=2
set statusline=
set statusline+=%6*\ [%{g:currentmode[mode()]}]               " Current mode
set statusline+=%4*\ [%n]:\                                 " buffer #
set statusline+=%4*%{&modified?'':g:status_fileName}        " get file name
set statusline+=%4*%{&modified?'':'\ '}                     " space after file
set statusline+=%7*%{&modified?g:status_fileName:''}        " change color is modified
set statusline+=%7*%{&modified?'\ ':''}                     " space after file
set statusline+=%7*%m%r%w                                   " show: modified, read only, and preview flags
set statusline+=%*
set statusline+=%1*\ %=                                     " right justified text
set statusline+=%1*\|\ %{&filetype}\                            " file type
set statusline+=\|\ %{&ff}\                                 " file format
set statusline+=\|\ %{FileSize()}\|                          " File size
set statusline+=\ %3*%2p%%
set statusline+=\ \|\ %2l:%-2c\                                 " line + column 

" }}}

