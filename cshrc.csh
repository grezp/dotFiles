# Set up tester specific stuff
if ( -r ~ictester/.testerconf ) then
   source ~ictester/.testerconf
endif

# Cohu env Paths
set which_ltx = /opt/ltx/os
setenv PATH  .:~/bin:/bin:/usr/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/local/sbin:/usr/X11R6/bin:/usr/local/Adobe/Acrobat7.0/bin:/opt/totalview/bin:/opt/ltx/bin:${which_ltx}/com:${which_ltx}/bin:${which_ltx}/cmd:${which_ltx}/scripts:${which_ltx}/service:${PATH}
setenv MANPATH /usr/man:/usr/local/man:/usr/share/man:/usr/X11R6/man
setenv LD_LIBRARY_PATH /opt/ltx/ltx_os/lib64:/lib:/usr/lib:/usr/X11R6/lib:/usr/local/lib:/opt/ltx/Qt/v5.9.3/3.10.0_m64/gcc-4.8.5/lib/:/opt/ltx/Qt/v5.9.3/3.10.0_m64/gcc-4.8.5/lib/
setenv CUSTOMER_DIR /ltx/customer/

#############################################################################
################################# USER EDITS ################################
#############################################################################

alias cp 'cp -i'
alias mv 'mv -i'
alias ls 'ls --color=auto'
alias ll 'ls -l'
alias la 'ls -la'
alias lr 'ls -ltr'
alias inuse "ps -efw | grep -E 'cmi|Bring|utlrt|dataviewer|evtc|optool|smc|start_diag|envif|nicmon|utlmon|utlio|utlinv|unisonif' | grep -vw grep"

# vncserver
alias vnc-home 'vncserver -geometry 2240x1260 :99 -AlwaysShared '

# resolution shortcuts
alias res-hd 'xrandr -s 1920x1080'
alias res-info 'xdpyinfo | grep dimensions'

# set default editor to nvim
setenv VISUAL vim
setenv EDITOR vim

# grep
alias llg       'll | grep'
alias lag       'la | grep'
alias g-word    'grep -rnw . -e $1'
alias g-phrase  'grep -rn . -e $1'
alias grep      'grep --color=auto'

# shortcuts
alias nv        'nvim'
alias cshell    'nvim ~/.cshrc_user'
alias csource   'source ~/.cshrc'
alias ctagsR    'ctags -R --c++-kinds=+p --fields=+iaS --extra=+q'
alias vman 'man $1 | vi -'

# command prompt
alias precmd "source ~/dotFiles/cshrc_prompt.csh"

# changes directory colors, use dircolors for more info
setenv LS_COLORS 'rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:ca=30;41:tw=30;45:ow=30;45:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.axv=01;35:*.anx=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.axa=00;36:*.oga=00;36:*.spx=00;36:*.xspf=00;36:'
# gcc color output
setenv GCC_COLORS 'error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'


# path exports
setenv PATH $HOME/scripts:${PATH}
setenv PATH $HOME/bin:${PATH}
setenv PATH /usr/local:${PATH}
setenv PATH ${PATH}:/ltx/scripts

# conda exports
setenv PATH $HOME/miniconda3/bin:$PATH
setenv LD_LIBRARY_PATH $HOME/miniconda3/lib:${LD_LIBRARY_PATH}
setenv MANPATH $HOME/miniconda3/share/man:${MANPATH}
#setenv LD_LIBRARY_PATH $HOME/local/lib:${LD_LIBRARY_PATH}

if ( $?MANPATH == 0 ) then
  setenv MANPATH $HOME/local/share/man
else
  setenv MANPATH $HOME/local/share/man:${MANPATH}
endif


# setenv CC $HOME/miniconda3/bin/gcc
# setenv CXX $HOME/miniconda3/bin/g++
setenv XDG_CONFIG_HOME $HOME/.config
# setenv LC_ALL='en_US.UTF-8'
# setenv LANG='en_US.UTF-8'



# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if ( -f "/usr2/pgutierr/miniconda3/etc/profile.d/conda.csh" ) then
    source "/usr2/pgutierr/miniconda3/etc/profile.d/conda.csh"
else
    setenv PATH "/usr2/pgutierr/miniconda3/bin:$PATH"
endif
# <<< conda initialize <<<

