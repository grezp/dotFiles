
#! /bin/csh
# 
# cshrc_template - This file may be copied into your ~/ directory and
# renamed to '.cshrc'.  
# 
#
########################################################################
#
# Revision History:
#
#  99-10-07     bji          Removed set DISPLAY
#  98-12-23     dc           Changed to use get_revision
#  98-10-19     dc           Changes for LTXHOME, set DISPLAY
#  96-03-21     srf          Fixed Device Tool entries.
#  95-12-18     swt/sherryl  Created. (cloned from kshrc_template)
#
########################################################################

if ( $?DEBUG_ON == 1 ) set echo

umask 002   # Set protections on created files.

# HOST_OS contains system OS type.
set HOST_OS = ( InvalidHostOS )
if ( -f /usr/bin/uname    ) set HOST_OS = ( `/usr/bin/uname` )   
if ( -f /bin/uname        ) set HOST_OS = ( `/bin/uname` )       
if ( -f /sys5.3/bin/uname ) set HOST_OS = ( `/sys5.3/bin/uname` )

# set ltx PATH components :
if ( -f /opt/ltx/bin/get_revision ) then
    set which_ltx = `/opt/ltx/bin/get_revision`
else if ( $?LTXHOME ) then
    set which_ltx = $LTXHOME
else
    set which_ltx = "/ltx"
endif

if ( -e $HOME/.user_cshrc ) then
   source $HOME/.user_cshrc
endif

if ( $HOST_OS == "Linux" ) then
    setenv PATH  ".:/bin:/usr/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/local/sbin:/usr/X11R6/bin:/usr/local/Adobe/Acrobat7.0/bin:/opt/totalview/bin:/opt/ltx/bin:${which_ltx}/com:${which_ltx}/bin:${which_ltx}/cmd:${which_ltx}/scripts:${which_ltx}/service:${PATH}"
    setenv MANPATH /usr/man:/usr/local/man:/usr/share/man:/usr/X11R6/man
else if ( $HOST_OS == "SunOS" ) then 
    # This path is written to give SYS V commands precedence over BSD equivalents.
    setenv PATH .:~/com:/usr/ccs/bin:/usr/bin:/usr/ucb:/bin:/etc:/usr/vue/bin:/opt/softbench/bin:/usr/local/bin:/usr/bin/X11:/usr/openwin/bin:/usr/openwin/bin/xview:/usr/openwin/lib:/usr/openwin/share:/opt/ltx/bin:${which_ltx}/com:${which_ltx}/cmd
    setenv MANPATH /usr/man:/usr/local/man:/usr/snm/man:/usr/openwin/man:/usr/vue/man
endif

set history = 1000                 # Increase history length.

# Device tool variables:
#setenv SDA_LOG_DIRECTORY "~/cdslogs"
#setenv CDS_NUM_USER_COLORS "48"
# Replace /cds with the actual install path of the Cadence Design Systems software.
#setenv CDS_INSTALL_PATH "/cds"
#setenv MANPATH "${MANPATH}:${CDS_INSTALL_PATH}/tools/dfII/man"
#setenv opusPath "${CDS_INSTALL_PATH}/tools/bin:${CDS_INSTALL_PATH}/tools/dfII/bin"
#setenv path "$PATH:$opusPath"

# General variables:
#setenv EDITOR nvim 
setenv CDPATH ".:~:${which_ltx}:/user"

# This variable is needed for X application resource files.
# NOTE: XUSERFILESEARCHPATH is preferred over XAPPLRESDIR in X11R4+
setenv XUSERFILESEARCHPATH ~/app-defaults/%N 

# Change 'blah' to a file name in /ltx/printers.  This will be the
# default printer for the ltx tools.
#setenv LTX_PRINTER blah

# Setting the LTX_UICPATH variable to a particular path will make all 
# tools search that path for their configuration files
#setenv LTX_UICPATH .:~/:${which_ltx}/site:${which_ltx}/defaults

alias   h  history       # Shortcut for history listing
alias   rm 'rm -i'       # Better safe than sorry

# This is creating an alias in the environment for every file in
# /usr/dmd/current/system/bin to first source
# /usr/dmd/current/setup/runtime_env.csh then run the executable in a separate
# csh process so that the setting of LD_LIBRARY_PATH gets set correctly to
# execute any legacy Diamonds executables.  The separate csh process is needed
# so that the enironment does not get tainted with legacy Diamond settings and
# thus breaking Unison execuatbles. This is sspecially important for things like
# Qt which uses different versions between Unison and legacy Diamond.

if ( -d /usr/dmd/current/system/bin ) then
  ls -1 /usr/dmd/current/system/bin/. | awk '{ printf("alias %s \047csh -c \"(source /usr/dmd/current/setup/runtime_env.csh ; /usr/dmd/current/system/bin/%s)\"\047\n",$1,$1); }' > /tmp/$$.cshrc
  source /tmp/$$.cshrc
  rm -rf /tmp/$$.cshrc >& /dev/null
endif


# set prompt = '[\!]% '
set prompt = "`whoami`@`hostname`> "

if (! $?LD_LIBRARY_PATH) then
	setenv LD_LIBRARY_PATH /lib:/usr/lib:/usr/X11R6/lib:/usr/local/lib
endif


# alias set_revision 'setenv chosen_ltx  \!*; source /opt/ltx/bin/set_revision.csh'
# allows the user to set LTXHOME in the current shell by typing
#    set_revision <path>
setenv XLM_ENABLE_LM_LICENSE_FILE 1

# Required for unison 
setenv XUSERFILESEARCHPATH /var/home/service/app-defaults/%N

# Add to PATH to get LTXC programs
setenv PATH ${PATH}:/ltx/bin:/ltx/com:/ltx/service:/ltx/scripts:/ltx/cmd:/ltx/apps_support/com

# Add to PATH to get acrobat reader
setenv PATH ${PATH}:/usr/local/Adobe/Acrobat7.0/bin

# Required for unison 
setenv LM_LICENSE_FILE 1705@srv-flexlm1-mil

setenv LD_LIBRARY_PATH ${LD_LIBRARY_PATH}:/opt/ltx/Qt/v5.9.3/3.10.0_m64/gcc-4.8.5/lib/
#setenv LD_LIBRARY_PATH ${LD_LIBRARY_PATH}:/opt/ltx/Qt/v5.6.0/3.10.0_m64/gcc-4.8.5/lib/


#############################################################################
################################# USER EDITS ################################
#############################################################################

alias cp 'cp -i'
alias mv 'mv -i'
alias ls 'ls --color=auto -F'
alias ll 'ls -lF'
alias la 'ls -laF'
alias lr 'ls -ltrF'
alias inuse "ps -efw | grep -E 'cmi|Bring|utlrt|dataviewer|evtc|optool|smc|start_diag|envif|nicmon|utlmon|utlio|utlinv|unisonif' | grep -vw grep"

#colors!!!!
set  green="%{\033[0;32m%}"
set   blue="%{\033[0;34m%}"
set    end="%{\033[0m%}"

#configure prompt
if($HOSTNAME == "irv-vappseng1-c72") then
   set prompt="${blue}%n${end}@${blue}c72${end}: ${blue}%~${end}$ " 
else if($HOSTNAME == "irv-vappseng1-c62") then
   set prompt="${blue}%n${end}@${blue}c62${end}: ${blue}%~${end}$ " 
else if($HOSTNAME == "unison-san101-01") then
   set prompt="${blue}%n${end}@${blue}qcm-sim${end}: ${blue}%~${end}$ " 
else 
   set prompt="${blue}%n${end}@${blue}%m${end}: ${blue}%~${end}$ " 
endif

# changes directory colors, use dircolors for more info
setenv LS_COLORS 'rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:ca=30;41:tw=30;45:ow=30;45:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.axv=01;35:*.anx=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.axa=00;36:*.oga=00;36:*.spx=00;36:*.xspf=00;36:'

alias grep 'grep --color=auto'

# vncserver
alias vnc-start 'vncserver $1'
alias vnc-kill 'vncserver -kill $1'
alias vnc-find 'ps -ef | grep 'pgutierr' | grep 'vnc''
alias vnc-home 'vncserver -geometry 2240x1260 :99'

alias res-info 'xdpyinfo | grep dimensions'

# set default editor to nvim
setenv VISUAL nvim
setenv EDITOR nvim

# grep inside file
alias g-word 'grep -rnw . -e $1'
alias g-phrase 'grep -rn . -e $1'

# shortcuts
alias nv 'nvim '
alias cshell 'nvim ~/.cshrc'
alias nvinit 'nvim ~/masterLinks/nvim/init.vim'
alias csource 'source ~/.cshrc'
alias wifi-find 'nmap -sP "10.20.1.*"'
alias ctagsR 'ctags -R --c++-kinds=+p --fields=+iaS --extra=+q'
alias kill-uni '~/documents/scripts/rs.rb'
alias vman 'man $1 | vi -'

# gcc color output
setenv GCC_COLORS 'error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Joes very long script
# --inFile=<control file> <csv pats>
alias di-pat './di-config.rb convert --mode=MIPI_SINGLE_BUS --conv-type=qcm --read-type=compare --read-strobe=60ns --wtset=TS52MHz_MIPI --rtset=TS26MHz_MIPI'

#exports
setenv PATH $HOME/scripts:${PATH}
setenv PATH ${PATH}:$HOME/.fzf/bin
setenv PATH $HOME/local/bin:${PATH}
setenv PATH $HOME/local/go/bin/:${PATH}
setenv PATH $HOME/bin:${PATH}
setenv PATH ${PATH}:/user/tools/Linux/bin
setenv PATH /usr/local/bin:${PATH}
setenv PATH /usr/local:${PATH}
setenv PATH "$HOME/miniconda3/bin:$PATH"
setenv PATH "$HOME/packages/lua/bin:$PATH"
setenv PATH "$HOME/.gem/ruby/2.7.0/bin:$PATH"

setenv LD_LIBRARY_PATH $HOME/miniconda3/lib:${LD_LIBRARY_PATH}

setenv MANPATH $HOME/local/share/man:${MANPATH}
setenv MANPATH $HOME/tools/llvm/share/man:${MANPATH}
setenv MANPATH $HOME/miniconda3/share/man:${MANPATH}
setenv MANPATH $HOME/.fzf/man:${MANPATH}

setenv CC /usr/local/bin/gcc
setenv CXX /usr/local/bin/g++
setenv XDG_CONFIG_HOME $HOME/.config
setenv CUSTOMER_DIR /ltx/customer/
# setenv LC_ALL='en_US.UTF-8'
# setenv LANG='en_US.UTF-8'

alias csf '/user/tools/LINUX/Development/CalfactorStudio/x86_64_linux_3.10.0/bin/CalfactorStudio'

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
# if ( -f "/u/pgutierr/miniconda3/etc/profile.d/conda.csh" ) then
#     source "/u/pgutierr/miniconda3/etc/profile.d/conda.csh"
# else
#     setenv PATH "/u/pgutierr/miniconda3/bin:$PATH"
# endif
# <<< conda initialize <<<
