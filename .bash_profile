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

function kube_current_context {
  token_lifetime_s=86400
  c_context=$(grep ^current-context ~/.kube/config 2>/dev/null | awk '{print $2}')
  if [ -n "$c_context" -a $(( $(date +%s) - $(stat -c %Y ~/.kube/config) )) -lt $token_lifetime_s ]; then
    c_user=$(echo $c_context | awk -F/ '{print $3 "/" $2}')
    if grep -A2 "\- name: $c_user" ~/.kube/config | grep -q token: ; then
      echo "($(echo $c_context | awk -F/ '{print $1}')) "
    fi
  fi
}

export GOPATH=$HOME/go
export OS_OUTPUT_GOPATH=1

export PATH=$PATH:$HOME/.local/bin:$HOME/bin:$GOPATH/bin

export PS1="\[\e[32m\]\$(parse_git_branch 2>/dev/null)\[\e[33m\]\$(kube_current_context)\[\e[m\][\h:\W]\\$ "
