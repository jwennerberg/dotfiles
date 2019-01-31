# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions

alias minishift-upstream="minishift --profile minishift-upstream start --openshift-version=v3.9.0 --memory=3GB"

# change prompt when using git
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1) /'
}

function get_oc_project {
  oc project 2>/dev/null | awk -F\" '{print "(" $2 ") "}'
}

function kube_current_context {
  c_context=$(grep ^current-context ~/.kube/config 2>/dev/null | awk '{print $2}')
  if [ -n "$c_context" -a $(( $(date +%s) - $(stat -c %Y ~/.kube/config) )) -lt 36000 ]; then
    c_user=$(echo $c_context | awk -F/ '{print $3 "/" $2}')
    if grep -A2 "\- name: $c_user" ~/.kube/config | grep -q token: ; then
      echo "($(echo $c_context | awk -F/ '{print $1}')) "
    fi
  fi
}

function k8s_current_namespace {
  #kubectl config current-context 2>/dev/null | awk -F/ '{print "("$1") "}'
  grep ^current-context ~/.kube/config |awk '{print $2}' |cut -f1 -d\/
}

function k8s_current_ns {
  kubeconfig=~/.kube/config
  token_lifetime_s=86400
  [ -n "$(kubectl config view --minify -o jsonpath='{.users[0].user.token}' 2>/dev/null)" -a \
    $(( $(date +%s) - $(stat -c %Y $kubeconfig) )) -lt $token_lifetime_s ] && \
  k8s_current_namespace
}

#export PS1="\[\e[32m\]\$(parse_git_branch 2>/dev/null)\[\e[m\][\h:\W]\\$ "
#export PS1="\[\e[32m\]\$(parse_git_branch 2>/dev/null)\[\e[33m\]\$(get_oc_project)\[\e[m\][\h:\W]\\$ "
export PS1="\[\e[32m\]\$(parse_git_branch 2>/dev/null)\[\e[33m\]\$(kube_current_context 2>/dev/null)\[\e[m\][\h:\W]\\$ "

# GO
export GOPATH=$HOME/go
export PATH=$PATH:$HOME/.local/bin:$HOME/bin:$GOPATH/bin
export OS_OUTPUT_GOPATH=1

###export PS1="\[\e[32m\]\$(parse_git_branch 2>/dev/null)\[\e[m\][\h:\W]\\$ "
###PS1="[\u@\h \W]\$ "

