# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs

# change prompt when using git
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1) /'
}

export GOPATH=$HOME/go
export OS_OUTPUT_GOPATH=1

export PATH=$PATH:$HOME/.local/bin:$HOME/bin:$GOPATH/bin

export PS1="\[\e[32m\]\$(parse_git_branch 2>/dev/null)\[\e[m\][\h:\W]\\$ "
