
"---BINDINGS TO REMEMBER---"
"--------------------------"
""""""""""""""""""""""""""""
" :set nowrap number relativenumber wildmenu foldmethod=syntax

"___Scroll/Position___"
"
" ^C-d  ------- half page down
" ^C-u  ------- half page up
" zL  --------- half page left
" zH  --------- half page right
"
" zt  --------- move cursor - window top
" zb  --------- move cursor - window bottom
" zz  --------- move cursor - window middle
"
" ^C-e  ------- single line down
" ^C-y  ------- single line up
" zl  --------- single line left
" zh  --------- single line right

"___Navigation___"
"
" m(x/X)  ------- [m] creates local/global mark
" '(x/X)  ------- ['] goes to local/global mark
" f(x)  ------- [f] finds next chard [F] for backwards

"___Buffers___"
"
" :sb#  ------- open buffer horiz
" :vert sb#  -- open buffer vertically
" :sp  -------- open new file horz
" :vs  -------- open new file horz
" <C-w>R ------ swap vert/horiz buffers
" <C-w>h  ----- mv buf <
" <C-w>j  ----- mv buf v
" <C-w>k  ----- mv buf ^
" <C-w>l  ----- mv buf >

"___Misc___"
"
" ^C-6  ------- toggle between last 2 buffers
" ^C-r  ------- redo prev cmd - undos undo
" "(#)  ------- ["] stores into reg, used with y/p
" .  ---------- repeat prev cmd

"___Nerdcommenter___"
" [#]<L>c<L> -- comment toggle
" [#]<L>cc  --- comment single line
" [#]<L>ci  --- remove single line comment
" [#]<L>cm  --- comment minimal block
" [#]<L>cs  --- comment sexy block
" <L>ca  ------ comment altDelims

"---GENERAL CONFIG OPTIONS---" {{{
"----------------------------"
""""""""""""""""""""""""""""""

"___General_settings___" {{{{
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
set shortmess=aWF           " cmd message: use abrevs,no write, no file text
set splitbelow              " open horiz splits below
set splitright              " open vert split right
" set path+=.,**
set wildmenu
set wildignorecase
set wildignore=*/build/*,*.bak
set tags+=tags
" Qualcomm only:
set tags+=/prj/vlsi/pete/qat3518_cohu/.tmp/.pgutierr/ltx_include/tags;
" }}}

"___Color_options___" {{{
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
hi TabLineFill guibg=#263033|                   " tab bar empty space 
hi TabLine guifg=#74baac guibg=#263033|         " inactive tab color -turtoise
hi TabLineSel guifg=#d881ed guibg=#263033|      " active tab color - dark magenta
" }}}

"___Pattern search___" {{{
"____________________"
set hlsearch                " high light search patterns
set incsearch               " find patter as you type
set ignorecase              " ignore case when searching
set smartcase               " stop ignorecase when searching w/ caps
" }}}

""___Cursor options___" {{{
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

"___General___" {{{
"_____________"
map <Space> <Leader>|                       " make space leader key
noremap <Leader>o o<Esc>|                   " enter new line below & gt normal
noremap <Leader>O O<Esc>|                   " enter new line above & gt normal
nnoremap <Leader>, :noh<CR>|                " stops highlight from search
cabbrev hv vert h|                          " creates help buffer to right vert split
" }}}

"___Buffers___" {{{
"_____________"
nnoremap gb :ls<CR>:buffer<Space>|     " list buffer then choose
nnoremap <Leader>bl :ls<CR>|           " list buffers
nnoremap <Leader>bL :Buffers<CR>|      " fzf buffer
nnoremap <C-k> :bnext<CR>|             " move to next buffer
nnoremap <C-j> :bprev<CR>|             " move to prev buffer
" }}}

"___System file___" {{{
"_________________"
nnoremap <Leader>s :w<CR>|               " saves current file
nnoremap <Leader>q :q<CR>|               " exit window
nnoremap <Leader>Q :q!<CR>|              " exit window w/o saving
" }}}

"___Windows___" {{{
"_____________"
map <Leader>w <C-w>|                             " window keybind
nnoremap <Leader>w+ 10<C-w>+|                    " inc window height 
nnoremap <Leader>w- 10<C-w>-|                    " dec window height
nnoremap <leader>w> 30<C-w>>|                    " inc > window height 
nnoremap <leader>w< 30<C-w><|                    " inc < window height
" }}}
"
" }}}

"---PLUGINS---" {{{
"-------------"
"""""""""""""""

"___Vim_plug___"
silent! call plug#begin()
    Plug 'preservim/nerdcommenter'                  " comment code easily
    Plug 'junegunn/fzf'                             " command line fuzzy finder
    Plug 'junegunn/fzf.vim'                         " fzf embeded into vim
    Plug 'tpope/vim-fugitive'                       " git wrapper for vim
    Plug 'ludovicchabant/vim-gutentags'             " ctag manager
call plug#end()

"___Nerdcommenter___" {{{
"___________________"
let g:NERDSpaceDelims = 1 |                 " adds space between comment & char
let g:NERDDefaultAlign = 'left' |           " flush single line comments
let g:NERDCommentEmptyLines = 1 |           " comment empty lines
" }}}

"___Fugitive___" {{{
"______________"
cabbrev git Git|            "git shrtcut
cabbrev vgit vert Git|      " vert git buff
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
hi User1 guifg=#b2b2b2 guibg=#263033            " white
hi User2 guifg=#e697e6 guibg=#263033            " magenta
hi User3 guifg=#20af81 guibg=#263033            " teal
hi User4 guifg=#74baac guibg=#263033            " turtoise
hi User5 guifg=#d881ed guibg=#263033            " dark magenta
hi User6 guifg=#263033 guibg=#20af81            " invert teal
" }}}}

" Check Modified File {{{
function! FileMod()
    if &modified
        let l:fileName = expand("%:f")
        return l:fileName
    else
        return ''
    endif
endfunction

function! FileNotMod()
    if &modified
        return ''
    else
        let l:fileName = expand("%:f")
        return l:fileName
    endif
endfunction
" }}}

set laststatus=2
set statusline=
set statusline+=%5*\ [%{g:currentmode[mode()]}]             " Current mode
set statusline+=%4*\ [%n]:\                                 " buffer #
set statusline+=%3*%{FileNotMod()}
set statusline+=%3*%{&modified?'':'\ '}                     " space after file
set statusline+=%6*%{FileMod()}
set statusline+=%6*%{&modified?'\ ':''}                     " space after file
set statusline+=%6*%m%r%w%h                                 " show: modified, read only, and preview flags
set statusline+=%1*\ %=                                     " right justified text
set statusline+=%1*\|\                                      " spaces & column sep.
set statusline+=%4*%{&filetype}                             " file type
set statusline+=%1*\ \|\                                    " spaces & column sep.
set statusline+=%4*%{&ff}                                   " file format
set statusline+=%1*\ \|\                                    " spaces & column sep.
set statusline+=%4*%{FileSize()}                            " File size
set statusline+=%1*\|\                                      " spaces & column sep.
set statusline+=%2*%2p%%                                    " percent
set statusline+=%1*\ \|\                                    " spaces & column sep.
set statusline+=%2*%2l:%-2c\                                " line + column
" }}}

" vim:fdm=marker
