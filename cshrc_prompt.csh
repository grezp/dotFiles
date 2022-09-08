
#colors!!!!
set  green="%{\033[0;32m%}"
set   blue="%{\033[0;34m%}"
set violet="%{\033[0;35m%}"
set  white="%{\033[0;37m%}"
set    end="%{\033[0m%}"

#configure prompt
setenv GIT_BRANCH_CMD "sh -c 'git branch --no-color 2> /dev/null' | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'"
set prompt="${white}╭─${end} ${violet}%n${end}${green}@${end}${violet}%m${end}:`$GIT_BRANCH_CMD` ${blue}%~${end} \n${white}╰─➤  ${end}"

