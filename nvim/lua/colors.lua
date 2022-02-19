vim.o.termguicolors = true              -- 24 bit colors
vim.cmd('colorscheme space-vim-dark')   -- http://www.calmar.ws/vim/256-xterm-24bit-rgb-color-chart.html

-- general
vim.cmd([[
    " change folding fg & bg color
    hi Folded gui=none guibg=#262626 guifg=#005f5f
    " tab bar empty space
    hi TabLineFill guibg=#263033
    " inactive tab color -turtoise
    hi TabLine guifg=#74baac guibg=#263033
    " active tab color - dark magenta
    hi TabLineSel guifg=#d881ed guibg=#263033
]])

-- cpp
vim.cmd([[
    " change floats to match int
    hi Float gui=none guifg=#d787d7
    hi def link cppSTLnamespace TabLine
]])

-- unison
vim.cmd([[
    " highlight unison Classes
    hi unisonClass gui=none  guifg=#5fd787
    " hi unison enums
    hi unisonEnums gui=none  guifg=#74baac
    " highlight usision data types
    hi unisonDataTypes gui=none  guifg=#5f87af
    " hi unison type defs
    hi unisonTypeDefs  gui=none  guifg=#5f87af
]])

-- status line
vim.cmd([[
    hi StatusSep    guifg=#b2b2b2 guibg=#263033    " white
    hi RhsStatusAlt guifg=#e697e6 guibg=#263033    " magenta
    hi StatusLine   guifg=#20af81 guibg=#263033    " teal
    hi StatusLineNC guifg=#167a5a guibg=#263033    " dark teal
    hi BufferNumber guifg=#74baac guibg=#263033    " turtoise
    hi RhsStatus    guifg=#74baac guibg=#263033    " turtoise
    hi Mode         guifg=#d881ed guibg=#263033    " dark magenta
    hi FileMods     guifg=#263033 guibg=#20af81    " invert teal
]])
