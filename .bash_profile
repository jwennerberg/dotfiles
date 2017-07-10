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

function k8s_current_namespace {
  kubectl config current-context 2>/dev/null | awk -F/ '{print "("$1") "}'
}

function k8s_current_ns {
  kubeconfig=~/.kube/config
  token_lifetime_s=86400
  [ -n "$(kubectl config view --minify -o jsonpath='{.users[0].user.token}' 2>/dev/null)" -a \
    $(( $(date +%s) - $(stat -c %Y $kubeconfig) )) -lt $token_lifetime_s ] && \
  k8s_current_namespace
}

export GOPATH=$HOME/go
export OS_OUTPUT_GOPATH=1

export PATH=$PATH:$HOME/.local/bin:$HOME/bin:$GOPATH/bin

export PS1="\[\e[32m\]\$(parse_git_branch 2>/dev/null)\[\e[33m\]\$(k8s_current_ns 2>/dev/null)\[\e[m\][\h:\W]\\$ "
