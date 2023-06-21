alias sudo='sudo '

alias l='ls -CF --group-directories-first'
alias ll='l -l'
alias la='l -A'
alias lla='ll -A'

alias grep='grep --color'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias cls='clear'

LIST=""


LIST="$LIST\n`find -L "$HOME/.programs/nvim/bin/" -perm /u=x,g=x,o=x -type f`"
LIST="$LIST\n`find -L "$HOME/.programs/texlive/2023/bin/x86_64-linux" -perm /u=x,g=x,o=x -type f`"

for list in $LIST;do
	alias "`basename $list`"="$list"
done
