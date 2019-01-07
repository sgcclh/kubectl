export PS1='[\W $(kube_ps1)]\$ '
alias ll="ls -la"
source /root/kube-ps1.sh
# Use bash-completion, if available
[[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] && \
    . /usr/share/bash-completion/bash_completion
export PATH=~/.kubectx:$PATH
source <(kubectl completion bash)
