
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
" Cohu only:
set tags+=/u/pgutierr/Projects/Qualcomm/thor/drivers/thorTags/tags
" Qualcomm only:
set tags+=/prj/vlsi/pete/qat3518_cohu/.tmp/.pgutierr/ltx_include/tags;
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
"
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
cabbrev vh vert h|                          " creates help buffer to right vert split
" }}}

"___Buffers___" {{{
"_____________"
nnoremap gb :ls<CR>:buffer<Space>|     " list buffer then choose
nnoremap <Leader>bl :ls<CR>|           " list buffers
nnoremap <Leader>bL :Buffers<CR>|      " fzf buffer
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

"---COLORS---" {{{
"------------"
""""""""""""""

"___Color_options___"
"___________________"
set termguicolors                               " 24 bit colors
syntax on                                       " Turn on syntax hilighting
colorscheme space-vim-dark                      " http://www.calmar.ws/vim/256-xterm-24bit-rgb-color-chart.html

" general
" so /usr/local/share/vim/vim82/syntax/hitest.vim 
hi Folded gui=none guibg=#262626 guifg=#005f5f| " change folding fg & bg color
hi TabLineFill guibg=#263033|                   " tab bar empty space 
hi TabLine guifg=#74baac guibg=#263033|         " inactive tab color -turtoise
hi TabLineSel guifg=#d881ed guibg=#263033|      " active tab color - dark magenta

" cpp
hi Float gui=none guifg=#d787d7|                " change floats to match int 
hi def link cppSTLnamespace TabLine

"___Unison keywords___" {{{
"_____________________"
syn keyword unisonClass CBIT CLOCK MATRIX CPMU DSP RF DIGITAL SYS SEQ GPIB TMU VI MATH ADC CODEC DAC EVM TIME CONV VP ERR IO
                      \ ProfileTT DIEXT DLOGMOD PARSEX GU THORSOLT THORRF SERVOTYPE SearchMod SEARCHM VSA Math VSAPlotter PLOT

syn keyword unisonDataTypes ArrayOfBasicVar ArrayOfBoolM ArrayOfBoolM1D ArrayOfBoolM2D ArrayOfBoolM3D ArrayOfBoolS ArrayOfBoolS1D ArrayOfBoolS2D ArrayOfBoolS3D ArrayOfFloatM ArrayOfFloatM1D ArrayOfFloatM2D ArrayOfFloatM3D ArrayOfFloatML ArrayOfFloatS 
                          \ ArrayOfFloatS1D ArrayOfFloatS2D ArrayOfFloatS3D ArrayOfFloatSL ArrayOfIntM ArrayOfIntM1D ArrayOfIntM2D ArrayOfIntM3D ArrayOfIntML ArrayOfIntS ArrayOfIntS1D ArrayOfIntS2D ArrayOfIntS3D ArrayOfIntSL ArrayOfObjectM ArrayOfObjectM1D
                          \ ArrayOfObjectM2D ArrayOfObjectM3D ArrayOfObjectML ArrayOfObjectS ArrayOfObjectS1D ArrayOfObjectS2D ArrayOfObjectS3D ArrayOfObjectSL ArrayOfPinM ArrayOfPinML ArrayOfStringM ArrayOfStringM1D ArrayOfStringM2D ArrayOfStringM3D
                          \ ArrayOfStringML ArrayOfStringS ArrayOfStringS1D ArrayOfStringS2D ArrayOfStringS3D ArrayOfStringSL ArrayOfUnsignedM ArrayOfUnsignedM1D ArrayOfUnsignedM2D ArrayOfUnsignedM3D ArrayOfUnsignedML ArrayOfUnsignedS ArrayOfUnsignedS1D
                          \ ArrayOfUnsignedS2D ArrayOfUnsignedS3D ArrayOfUnsignedSL BoolM BoolM1D BoolM2D BoolM3D BoolS BoolS1D BoolS2D BoolS3D FloatM FloatM1D FloatM2D FloatM3D FloatML FloatS FloatS1D FloatS2D FloatS3D FloatSL IntM IntM1D IntM2D IntM3D
                          \ IntML IntS IntS1D IntS2D IntS3D IntSL MagicVar ObjectM ObjectM1D ObjectM2D ObjectM3D ObjectML ObjectS ObjectS1D ObjectS2D ObjectS3D ObjectSL PinM PinML StringM StringM1D StringM2D StringM3D StringML StringS StringS1D StringS2D
                          \ StringS3D StringSL UnsignedM UnsignedM1D UnsignedM2D UnsignedM3D UnsignedML UnsignedS UnsignedS1D UnsignedS2D UnsignedS3D UnsignedSL

syn keyword unisonTypeDefs RFAutoCalConnectModeM RFAutoCalConnectModeM1D RFAutoCalConnectModeS RFAutoCalStatusS RFAutoCalTypeS RFAverageModeM RFAverageModeM1D RFAverageModeS RFCalSetupModeS RFDataModeM RFDataModeM1D RFDataModeS RFDataSliceM RFDataSliceM1D
                         \ RFDataSliceS RFExternalSourceS RFFilterTypeM RFFilterTypeM1D RFFilterTypeS RFFrequencyDomainModeM RFFrequencyDomainModeM1D RFFrequencyDomainModeS RFFrequencyTypeM RFFrequencyTypeM1D RFFrequencyTypeS RFIFOutputM RFIFOutputM1D
                         \ RFIFOutputS RFInitializeS RFInterpolationTypeM RFInterpolationTypeM1D RFInterpolationTypeS RFLogAmpM RFLogAmpM1D RFLogAmpS RFMeasureModeM RFMeasureModeM1D RFMeasureModeS RFModulationModeM RFModulationModeM1D RFModulationModeS
                         \ RFNoiseCalFactorTypeS RFNoiseResultTypeM RFNoiseResultTypeM1D RFNoiseResultTypeS RFNoiseSourceM RFNoiseSourceM1D RFNoiseSourceS RFPathModeM RFPathModeM1D RFPathModeS RFPathS RFPerformanceS RFPhaseNoiseOptimizationModeM
                         \ RFPhaseNoiseOptimizationModeM1D RFPhaseNoiseOptimizationModeS RFPrecisionM RFPrecisionM1D RFPrecisionS RFResourceModeM RFResourceModeM1D RFResourceModeS RFSamplingModeM RFSamplingModeM1D RFSamplingModeS RFSequenceModeM
                         \ RFSequenceModeM1D RFSequenceModeS RFSetupModeM RFSetupModeM1D RFSetupModeS RFSetupModeS1D RFSetupModeS2D RFSetupTypeS RFSourceTypeS RFSyncModeS RFToneM RFToneM1D RFToneS RFVectorResultTypeM RFVectorResultTypeM1D RFVectorResultTypeS
                         \ Sites SiteIter RunTime
                         \ PinMLIter
                         \ TMResultM TMResultM1D TMResultS TMResultS1D WordOrientationS
                         \ ThorRFPort MEASUREMENTTYPE PORTTYPE

syn keyword unisonEnums RF_AUTOCAL_DISCONNECTED RF_AUTOCAL_OPEN RF_AUTOCAL_SHORT RF_AUTOCAL_50OHM RF_AUTOCAL_75OHM RF_AUTOCAL_THRU RF_AUTOCAL_THRU_10DB RF_AUTOCAL_POWER_SENSOR RF_AUTOCAL_NOISE_SOURCE RF_AUTOCAL_EXTERNAL_SOURCE RF_AUTOCAL_EXTERNAL_SOURCE_TO_POWER_SENSOR
                      \ RF_AUTOCAL_OK RF_AUTOCAL_COULD_NOT_OPEN RF_AUTOCAL_COULD_NOT_CLOSE RF_AUTOCAL_ERROR RF_AUTOCAL_NUM RF_AUTOCAL_16 RF_AUTOCAL_32 RF_AUTOCAL_NONE RF_AVERAGE_UTP RF_AVERAGE_POWER RF_CAL_SETUP_MODE_SOURCE RF_CAL_SETUP_MODE_MEASURE RF_CAL_SETUP_MODE_NOISE
                      \ RF_CAL_SETUP_MODE_VECTOR RF_CAL_SETUP_MODE_SWEPT RF_CONSTR_SOURCE_LEVEL RF_CONSTR_SOURCE_FREQUENCY RF_CONSTR_MEASURE_LEVEL RF_CONSTR_MEASURE_RESBW RF_CONSTR_IF_GAIN RF_CONSTR_LO_FREQUENCY RF_CONSTR_SAMPLES RF_CONSTR_SAMPLE_RATE RF_CONSTR_UTP_AVERAGES
                      \ RF_CONSTR_TIMEOUT RFDIG_CONSTR_CARRIER RFDIG_CONSTR_LO_FREQUENCY RFDIG_CONSTR_LPF_FREQUENCY RF_CONSTR_NUM RF_DATA_CALIBRATED RF_DATA_RAW RF_ALL_DATA RF_NOISE_COLD RF_NOISE_HOT RF_2PORT_FORWARD RF_2PORT_REVERSE RF_EXTERNAL_SOURCE_ON
                      \ RF_EXTERNAL_SOURCE_OFF RF_FILTER_BAND_PASS RF_FILTER_LOW_PASS RF_FILTER_HIGH_PASS RF_FILTER_NONE RF_FFT RF_POWER_AVERAGE RF_POWER_FFT RF_LOG_DBC RF_LOG_DBM RF_IF_FREQUENCY RF_LO_FREQUENCY RF_IF_TO_DIGITIZER RF_IF_EXTERNAL RF_IF_TO_ANALOG_MONITOR
                      \ RF_INITIALIZE_FULL RF_INITIALIZE_PARTIAL RF_HW_INTERPOLATION RF_SW_INTERPOLATION RF_LOG_AMP_DIGITIZER RF_LOG_AMP_ABUS1 RF_LOG_AMP_ABUS3 RF_SCALAR RF_INCIDENT  RF_REFLECTED RF_LOOPBACK RF_MODULATION_I RF_MODULATION_Q RF_MODULATION_I_Q
                      \ RF_CALFACTOR_NOISE_ENR RF_CALFACTOR_NOISE_PCOLD RF_CALFACTOR_NOISE_GAIN_BANDWIDTH RF_CALFACTOR_NOISE_NFSYS RF_CALFACTOR_NOISE_PORT_DSA RF_CALFACTOR_TYPE_NUM RF_NOISE_FIGURE RF_NOISE_FACTOR RF_NOISE_GAIN RF_NOISE_ON RF_NOISE_OFF RF_THRU_THRU
                      \ RF_GAIN_THRU RF_THRU_GAIN RF_GAIN_GAIN RF_PATH_NUM RF_PATH_NORMAL RF_PATH_LOCKED RF_PERFORMANCE_HIGH_LINEARITY RF_PERFORMANCE_HIGH_SNR RF_PERFORMANCE_ENHANCED_SNR RF_PHASE_NOISE_BEST_WIDE_OFFSET RF_PHASE_NOISE_BEST_CLOSE_IN
                      \ RF_PHASE_NOISE_OPTIMIZATION_TYPE_NUM RF_LOW_PRECISION RF_HIGH_PRECISION RF_DEFAULT_MODE RF_GEN_PER_PORT RF_GEN_PER_PORT RF_GEN_SPLIT RF_GEN_RESERVED RF_GEN_SPLIT_RESERVED RF_GEN_SHARED RF_DIG_SAME_BOARD RF_DIG_DISTINCT_BOARD
                      \ RF_SAMPLING_AUTO RF_MINIMUM_INTERPOLATION RF_ZERO_ORDER_HOLD RF_SEQUENCE_USER RF_SEQUENCE_INTERNAL RF_AWG_RESERVED RF_DIG_RESERVED  RF_SOURCE_CW RF_SOURCE_MOD RF_SOURCE_2TONE RF_SOURCE_2TONE_MOD RF_SOURCE_2TONE_CW_MOD RF_SOURCE_NOISE
                      \ RF_MEASURE RF_MEASURE_LOG_AMP RF_MEASURE_VECTOR RF_MEASURE_SWEPT RF_MEASURE_EXTENDED RF_SETUP_SRC RF_SETUP_MSR RF_SOURCE_INTERNAL RF_SOURCE_EXTERNAL RF_S11 RF_SYNC_MODE_SYNCHRONOUS RF_SYNC_MODE_ASYNCHRONOUS RF_S21 RF_S12 RF_S22 RF_TONE_1
                      \ RF_TONE_2 RF_TONE_BOTH RF_MA RF_RI RF_DB RF_REAL RF_IMAG RF_MAG RF_ANG RF_MA_PAIR RF_RI_PAIR RF_VECTOR_CARTESIAN RF_VECTOR_LOG_POLAR  RF_VECTOR_POLAR RF_VECTOR_VSWR RF_VECTOR_RETURN_LOSS 
                      \ SV_CONFIG_NONE SV_SCALAR_S SV_SCALAR_M SV_ARRAY_S1D SV_ARRAY_M1D SV_ARRAY_S2D SV_ARRAY_M2D SV_ARRAY_S3D SV_ARRAY_M3D SV_LIST_S SV_LIST_M SV_MAX_CONFIG SV_CONTENT_KEEP SV_CONTENT_LOSE SV_TYPE_NONE SV_INT SV_UINT SV_FLOAT SV_BOOL SV_STRING SV_PIN
                      \ SV_OBJECT SV_ENUM SV_ARRAY_OF SV_MAX_TYPE SV_RANGE_AUTO SV_RANGE_1a SV_RANGE_1f SV_RANGE_1p SV_RANGE_1n SV_RANGE_1u SV_RANGE_1m SV_RANGE_1 SV_RANGE_1K SV_RANGE_1M SV_RANGE_1G SV_RANGE_1T SV_RANGE_1P SV_RANGE_1E
                      \ VI_ACCURACY_HIGH VI_ACCURACY_LOW VI_ALARM_NONE VI_ALARM_CLAMP_MAX VI_ALARM_CLAMP_MIN VI_ALARM_CLAMP VI_ALARM_DUTY_CYCLE VI_ALARM_GATE VI_ALARM_UNDERCURRENT VI_ALARM_TEMP VI_ALARM_MEASURE_OVERFLOW VI_ALARM_MEASURE_UNDERFLOW VI_ALARM_TRANSIENT_HIGHLIMIT
                      \ VI_ALARM_TRANSIENT_LOWLIMIT VI_ALARM_KELVIN_LOW VI_ALARM_KELVIN_HIGH VI_ALARM_TRIGGER VI_ALARM_ALLBITS VI_COMP_MIN_RISE_TIME VI_COMP_MIN_SETTLING_TIME VI_COMP_MIN_OVERSHOOT VI_COMP_MIN_RESISTANCE VI_CONFIG_PULSED VI_CONFIG_CONTINUOUS VI_MODE_LOCAL
                      \ VI_MODE_REMOTE VI_MODE_REMOTE_HIZ VI_MODE_VM VI_MODE_THROUGH VI_MODE_DISCHARGE VI_CONNECT_MS_HS VI_CONNECT_MS_LS VI_CONNECT_MS_BOTH VI_TO_DUT VI_TO_ABUS VI_LOOPBACK VI_DISCONNECTED VI_CONSTR_VFORCE VI_CONSTR_IFORCE VI_CONSTR_VCLAMP_MAX
                      \ VI_CONSTR_VCLAMP_MIN VI_CONSTR_ICLAMP_MAX VI_CONSTR_ICLAMP_MIN VI_CONSTR_VMEASURE VI_CONSTR_IMEASURE VI_CONSTR_MEASURE_SAMPLES VI_CONSTR_MEASURE_DELAY VI_CONSTR_MEASURE_TRIGGER_DELAY VI_CONSTR_GATE_TIME VI_CONSTR_RIPPLE_GAIN VI_CONSTR_CLOAD
                      \ VI_CONSTR_RLOAD VI_CONSTR_COMP_T1 VI_CONSTR_COMP_T2 VI_CONSTR_COMP_GAIN VI_CONSTR_CONFIG_V VI_CONSTR_CONFIG_I VI_CONSTR_WAVEFORM_SAMPLE_RATE VI_CONSTR_WAVEFORM_LOOP_COUNT VI_CONSTR_WAVEFORM_SAMPLES VI_CONSTR_CHARGE_WAIT_THRESHOLD
                      \ VI_CONSTR_BANDWIDTH_FREQUENCY VI_CONSTR_KELVIN_ALARM_THRESHOLD VI_CONSTR_TRANSIENT_VOLTAGE VI_CONSTR_TRANSIENT_CURRENT VI_CONSTR_NUM VI_FILTER_BYPASS VI_FILTER_LOW_PASS VI_GATE_AUTO_OFF VI_GATE_NO_AUTO_OFF VI_GATE_TRIGGERED VI_GATE_ON
                      \ VI_GATE_OFF_LOZ VI_GATE_OFF_HIZ VI_GUARD_FLOATING VI_GUARD_GROUNDED VI_GUARD_DRIVEN VI_MEASURE_FILTER_V VI_MEASURE_FILTER_I VI_MEASURE_FILTER_V_I VI_MEASURE_FILTER_OFF VI_MEASURE_AVERAGE VI_MEASURE_SAMPLES VI_RAILS_POSITIVE VI_RAILS_NEGATIVE
                      \ VI_RAILS_BALANCED VI_RIPPLE_TO_DUT VI_RIPPLE_TO_DUT_DIFF VI_RIPPLE_TO_ABUS VI_RIPPLE_TO_ABUS_DIFF VI_RIPPLE_SOURCE VI_RIPPLE_DISCONNECTED VI_RIPPLE_NONINVERTED VI_RIPPLE_INVERTED VI_SOURCE_VIS VI_SOURCE_PAS VI_SOURCE_LOAD_CONTINUITY
                      \ VI_SOURCE_LOAD_LEAKAGE VI_SWITCH_AUTO VI_SWITCH_HOT VI_TRIGGER_START VI_TRIGGER_STEP VI_TRIGGER_GATE VI_WAVEFORM_ARBITRARY VI_WAVEFORM_SINE VI_WAVEFORM_NULL_SINE VI_WAVEFORM_RAMP VI_WAVEFORM_TRIANGLE
                      \ DIGITAL_BIST_NONE DIGITAL_BIST_DONE DIGITAL_BIST_TIMEOUT DIGITAL_CAPTURE_PARALLEL DIGITAL_CAPTURE_SERIAL DIGITAL_CMP_MODE_PATTERN DIGITAL_CMP_MODE_MASK DIGITAL_CMP_MODE_ACTIVE DIGITAL_CMP_MODE_FLOAT DIGITAL_CMP_VOL DIGITAL_CMP_VOH DIGITAL_CMP_STATE_LOW
                      \ DIGITAL_CMP_STATE_HIGH DIGITAL_CMP_STATE_FLOAT DIGITAL_CMP_STATE_REVERSE DIGITAL_CMP_STATE_UNKNOWN DIGITAL_DCL_TO_DUT DIGITAL_ABUS_TO_DUT DIGITAL_ALL_PATHS DIGITAL_LIN_DCL_TO_DUT DIGITAL_CAN_DCL_TO_DUT DIGITAL_CONSTR_VIL DIGITAL_CONSTR_VIH
                      \ DIGITAL_CONSTR_VOH DIGITAL_CONSTR_VOL DIGITAL_CONSTR_IOH DIGITAL_CONSTR_IOHR DIGITAL_CONSTR_IOL DIGITAL_CONSTR_IOLR DIGITAL_CONSTR_VREF DIGITAL_CONSTR_VCH DIGITAL_CONSTR_VCL DIGITAL_CONSTR_RLV DIGITAL_CONSTR_REG_SEND_WORD_SIZE DIGITAL_CONSTR_DSP_SEND_WORD_SIZE
                      \ DIGITAL_CONSTR_CAPTURE_WORD_SIZE DIGITAL_CONSTR_CLV DIGITAL_CONSTR_VOH_HYSTERESIS DIGITAL_CONSTR_VOL_HYSTERESIS DIGITAL_CYCLE_COUNTER DIGITAL_INHIBIT_CYCLE_COUNTER DIGITAL_FAIL_COUNTER DIGITAL_COUNTER_CA DIGITAL_COUNTER_CB DIGITAL_COUNTER_CC DIGITAL_COUNTER_CD
                      \ DIGITAL_DIFF_NONE DIGITAL_DIFF_INPUT DIGITAL_DIFF_OUTPUT DIGITAL_DIFF_BIDIRECT DIGITAL_DRV_MODE_PATTERN DIGITAL_DRV_MODE_LOW DIGITAL_DRV_MODE_HIGH DIGITAL_DRV_MODE_OFF DIGITAL_DRV_MODE_ON DIGITAL_DRV_STATE_OFF DIGITAL_DRV_STATE_LOW DIGITAL_DRV_STATE_HIGH
                      \ DIGITAL_DRV_T1 DIGITAL_DRV_T2 DIGITAL_DRV_T3 DIGITAL_DRV_T4 DIGITAL_CMP_T1 DIGITAL_CMP_T2 DIGITAL_CMP_T3 DIGITAL_CMP_T4 DIGITAL_MEM_PASS DIGITAL_MEM_FAIL DIGITAL_MEM_REPAIRABLE DIGITAL_MEM_NON_REPAIRABLE DIGITAL_MEM_DEAD DIGITAL_MEM_TIMEOUT
                      \ DIGITAL_PACK_BY_PINS DIGITAL_PACK_BY_CYCLE DIGITAL_PATTERN_IDLE DIGITAL_PATTERN_RUNNING DIGITAL_PATTERN_KAP DIGITAL_SEARCH_BINARY DIGITAL_SEARCH_LINEAR DIGITAL_SEARCH_BINARY_LINEAR DIGITAL_SEARCH_LINEAR_LINEAR DIGITAL_SEARCH_LINEAR_PASS_TO_FAIL
                      \ DIGITAL_SEARCH_LINEAR_FAIL_TO_PASS DIGITAL_SEARCH_SUCCESSFUL DIGITAL_SEARCH_NO_TRANSITION_FAIL DIGITAL_SEARCH_NO_TRANSITION_PASS DIGITAL_SEARCH_NO_TRANSITION_FAIL_TO_PASS DIGITAL_SEARCH_NO_TRANSITION_PASS_TO_FAIL DIGITAL_SEND_SWITCH_START
                      \ DIGITAL_SEND_SWITCH_NEXT DIGITAL_SEND_SWITCH_LAST DIGITAL_SEND_PARALLEL DIGITAL_SEND_SERIAL DIGITAL_TRIGGER_EDGE DIGITAL_TRIGGER_PULSE DIGITAL_TRIGGER_LATCH
                      \ COLLECT_RESET COLLECT_ACCUMULATE CONNECT_OFF CONNECT_ON EDGE_RISING EDGE_FALLING MEASURE_PARALLEL MEASURE_SERIAL OPTIMIZE_FOR_SPEED OPTIMIZE_FOR_ACCURACY
                      \ TM_PASS TM_FAIL TM_NOTEST TM_PARAM_FAIL TM_REPAIRABLE TM_TIMEOUT WORD_MSB_FIRST WORD_LSB_FIRST
                      \ PORTTYPE HPRF RX TRX SCALAR PIN H2 H3
                      \ ActiveSites EnabledSites LoadedSites SelectedSites SuspendedSites

"___Unison colors___"
"___________________"
hi unisonClass gui=none  guifg=#5fd787|         " highlight unison Classes
hi unisonEnums gui=none  guifg=#74baac|         " hi unison enums
hi unisonDataTypes gui=none  guifg=#5f87af|     " highlight usision data types
hi unisonTypeDefs  gui=none  guifg=#5f87af|     " hi unison type defs
" }}}

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
"
""___Folding function___" {{{
""______________________"

" stops from auto unfolding while in insert mode
autocmd InsertEnter * if !exists('w:last_fdm') | let w:last_fdm=&foldmethod | setlocal foldmethod=manual | endif
autocmd InsertLeave,WinLeave * if exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif
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
