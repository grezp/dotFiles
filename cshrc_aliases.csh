if ( `cleartool pwv -s |& grep -c NONE` == '1' ) then
	set	curview=''
	unalias vwci
else
	set curview=`cleartool pwv -s`:
	set cview=`cleartool pwv -s`
	alias   vwci        "ct find -avobs -bra 'brtype($cview)' -nxname -print"
endif

alias pst           'ps -ef | grep "`whoami`"'   
alias lld           'ls -al | grep drw'
alias lll           'ls -al | grep lrw'
alias msg           'xmsg -nd -nh -nc -msg'
alias x11           '/user/tools/LINUX/bin/x11vnc -display :0'
alias diskuse       'du -ks * | sort -n'
alias launcher      "/ltx/com/launcher"
alias vmware        "/usr/bin/vmware-toolbox&"
alias stats         "/u/rftools/bin/RealTimeStatsTool&"
alias which_ltx     "/ltx/scripts/which_ltx"
alias which_os      'ls /opt/ltx/releases | grep'
alias which_cal     'more /opt/ltx_nic/calfiles/RF32Calibration.xml | grep RF32 | grep -v "\/" | sort'
alias lsc           '/user/tools/bin/lsclient'
alias cex           '/ltx/com/cex'
alias demodTool     '/u/jkondel/DemodDebug/DemodToolGui/DemodTool'
alias cmiService    '/ltx/bin/cmiService'

#Software (Clearcase)
alias cta   'ct lsact -short -cact'
alias ctd   'ct diff -pred'
alias ctdg  'ct diff -graph -pred'
alias cti   'ct ci -nc'
alias ctl   'ct lsco -avobs -cview -me -s'
alias ctla  'ct lsact -short | grep act'
alias ctli  'ct lsact -l `ctla` | grep "@@" | sort'
alias cto   'ct co -nc'
alias ctp   'ct pwv -short'
alias ctreb 'ct rebase -rec -com'
alias ctsa  'ct setactivity'
alias cts   'ct setview'
alias ctu   'ct unco'
alias ctv   'ct lsview -short | grep pgutierr | grep -v integration | sort'


alias se     'setenv LTX_UT_ERROR_HANDLER Learn'
alias ue     'unsetenv LTX_UT_ERROR_HANDLER'


# wave & cal factors
alias cfs   '/user/tools/LINUX/bin/cfs &'
alias ws    '/user/tools/LINUX/bin/ws &'
alias wa    '/user/tools/LINUX/bin/wa &'
alias pdf   '/user/tools/`uname`/bin/acroread &'


alias oss       'ls -1 /opt/ltx/releases/ | grep pgutierr_ | sort'
alias cp_build  '/user/tools/linux/bin/copy_build -to po -b '
alias p_target  'echo $TARGET_NAME'
alias cgmakeg   'cgmake BUILD_TYPE=dbg'
alias sbld      'source $HOME/scripts/set_bld'

alias lg    'ls | grep -i'
alias lrg   'lr | grep -i'

#WS Tools
alias cddev       "cd /user/tools/linux/Development"
alias cdws        "cd /vobs/ui/tools/WaveformStudio"
alias cdwa        "cd /vobs/ui/tools/WaveformAnalyzer"
alias cdcfs       "cd /vobs/ui/tools/CalfactorStudio"

alias cfsd        "$CADENCE_DIR/../CalfactorStudio/$ARCH_NAME/bin/CalfactorStudio &"
alias wad         "$CADENCE_DIR/../WaveformAnalyzer/$ARCH_NAME/bin/WaveformAnalyzer &"
alias wsd         "$CADENCE_DIR/../WaveformStudio/$ARCH_NAME/bin/WaveformStudio &"

alias gcdev     git clone /u/pgutierr/Git/diags-debug.git'
alias gcdevp    git clone ma-pgutierrez-72vm:/u/pgutierr/Git/diags-debug.git'
