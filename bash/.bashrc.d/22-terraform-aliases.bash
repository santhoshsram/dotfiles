# Terraform Aliases

alias tf='f(){ echo "Running: terraform $*"; terraform "$@"; }; f'
alias tfo="echo \"Running: terraform output -json | jq 'keys[]'\"; terraform output -json | jq 'keys[]'"
alias tfp='echo "Running: terraform plan"; terraform plan'
alias tfps='echo "Running: terraform plan -no-color | grep -E \"^  # |^Plan:\""; terraform plan -no-color | grep -E "^  # |^Plan:"'
alias tfv='echo "Running: terraform validate"; terraform validate'
