# Kubernetes Aliases

alias khelp='echo "
Kubernetes Aliases:
  k <cmd>     - kubectl (any command)
  kgns        - get namespaces
  kgn         - get nodes
  kgnd        - get nodes (detailed: name, status, capacity, max_pods)
  kgp         - get pods
  kgpa        - get pods (all namespaces)
  kgs         - get services
  kgd         - get deployments
  ktn         - top nodes
  ktp         - top pods
  ktpa        - top pods (all namespaces)
  kdp <pod>   - describe pod
  kdn <node>  - describe node
  kl <pod>    - logs
  klf <pod>   - logs (follow)
  kctx        - current context
  kctxs       - list contexts
"'

alias k='f(){ echo "Running: kubectl $*"; kubectl "$@"; }; f'

# get resources
alias kgns='echo "Running: kubectl get namespaces"; kubectl get namespaces'
alias kgn='echo "Running: kubectl get nodes"; kubectl get nodes'
alias kgnd='echo "Running: kubectl get nodes -o custom-columns=NAME:.metadata.name,STATUS:.status.conditions[-1].type,CAPACITY:.status.capacity.pods,MAX_PODS:.status.capacity.pods"; kubectl get nodes -o custom-columns="NAME:.metadata.name,STATUS:.status.conditions[-1].type,CAPACITY:.status.capacity.pods,MAX_PODS:.status.capacity.pods"'
alias kgp='echo "Running: kubectl get pods"; kubectl get pods'
alias kgpa='echo "Running: kubectl get pods --all-namespaces"; kubectl get pods --all-namespaces'
alias kgs='echo "Running: kubectl get services"; kubectl get services'
alias kgd='echo "Running: kubectl get deployments"; kubectl get deployments'

# top (resource usage)
alias ktn='echo "Running: kubectl top nodes"; kubectl top nodes'
alias ktp='echo "Running: kubectl top pods"; kubectl top pods'
alias ktpa='echo "Running: kubectl top pods --all-namespaces"; kubectl top pods --all-namespaces'

# describe
alias kdp='f(){ echo "Running: kubectl describe pod $*"; kubectl describe pod "$@"; }; f'
alias kdn='f(){ echo "Running: kubectl describe node $*"; kubectl describe node "$@"; }; f'

# logs
alias kl='f(){ echo "Running: kubectl logs $*"; kubectl logs "$@"; }; f'
alias klf='f(){ echo "Running: kubectl logs -f $*"; kubectl logs -f "$@"; }; f'

# context and config
alias kctx='echo "Running: kubectl config current-context"; kubectl config current-context'
alias kctxs='echo "Running: kubectl config get-contexts"; kubectl config get-contexts'
