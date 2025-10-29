# ==================================================
# 🧩 DevOps Aliases & Helpers (K8s / AWS / Terraform)
# Displays the actual command being executed with context + namespace
# Works with Zsh & Bash
# ==================================================

# -----------------------------------
# 🧹 Clean old aliases to avoid conflicts
# -----------------------------------
for a in k kgp kgs kgns kgpa kgn kgd kgi klo kex kdel kdesc kapply kedit \
         kcn kndef kns kctx kcctx ksctx kwhere awswho awsls awsprofiles \
         awsu ekslist eksuse awspubip awsswitch tf tfi tfp tfa tfd tfv tfs \
         tfws tfwsl tfdtarget devstatus khelp; do
  unalias "$a" 2>/dev/null
done

# -----------------------------------
# ✅ Zsh-compatible completions
# -----------------------------------
if command -v aws_completer >/dev/null 2>&1; then
  autoload -Uz bashcompinit && bashcompinit
  complete -C "$(which aws_completer)" aws
fi

if command -v terraform >/dev/null 2>&1; then
  autoload -Uz bashcompinit && bashcompinit
  complete -C "$(which terraform)" terraform
fi

# -----------------------------------
# 🪪 Helper to show context + namespace
# -----------------------------------
k8s_prefix() {
  ctx=$(kubectl config current-context 2>/dev/null || echo "-")
  ns=$(kubectl config view --minify --output 'jsonpath={..namespace}' 2>/dev/null || echo "default")
  echo "☸️ ${ctx} / ${ns} ->"
}

# -----------------------------------
# ☸️ Kubernetes Commands
# -----------------------------------

k() {
  echo "$(k8s_prefix) ⚙️ (kubectl $*) → Run a kubectl command"
  kubectl "$@"
}

kgp() {
  echo "$(k8s_prefix) 📦 (kubectl get pods) → List pods in the current namespace"
  kubectl get pods "$@"
}

kgs() {
  echo "$(k8s_prefix) 🔌 (kubectl get svc) → List services in the current namespace"
  kubectl get svc "$@"
}

kgns() {
  echo "$(k8s_prefix) 🏷️ (kubectl get ns) → List all namespaces"
  kubectl get ns "$@"
}

kgpa() {
  echo "$(k8s_prefix) 📦 (kubectl get pods -A) → List pods across ALL namespaces"
  kubectl get pods -A "$@"
}

kgn() {
  echo "$(k8s_prefix) 🖥️ (kubectl get nodes -o wide) → List nodes with wide output"
  kubectl get nodes -o wide "$@"
}

kgd() {
  echo "$(k8s_prefix) 🚀 (kubectl get deployments) → List deployments"
  kubectl get deployments "$@"
}

kgi() {
  echo "$(k8s_prefix) 🌐 (kubectl get ingress) → List ingress resources"
  kubectl get ingress "$@"
}

klo() {
  echo "$(k8s_prefix) 📜 (kubectl logs -f) → Stream logs for a pod"
  kubectl logs -f "$@"
}

kex() {
  echo "$(k8s_prefix) 🔧 (kubectl exec -it) → Execute a command inside a pod"
  kubectl exec -it "$@"
}

kdel() {
  echo "$(k8s_prefix) ❌ (kubectl delete) → Delete a Kubernetes resource"
  kubectl delete "$@"
}

kdesc() {
  echo "$(k8s_prefix) 🔎 (kubectl describe) → Describe a Kubernetes resource"
  kubectl describe "$@"
}

kapply() {
  echo "$(k8s_prefix) 📤 (kubectl apply -f) → Apply a manifest file"
  kubectl apply -f "$@"
}

kedit() {
  echo "$(k8s_prefix) ✏️ (kubectl edit) → Edit a Kubernetes resource in place"
  kubectl edit "$@"
}

# -----------------------------------
# 🏷️ Namespace Management
# -----------------------------------

kcn() {
  echo "$(k8s_prefix) 🏷️ (kubectl config view --minify --output jsonpath={..namespace}) → Show current namespace"
  kubectl config view --minify --output "jsonpath={..namespace}" || echo "default"
}

kndef() {
  echo "$(k8s_prefix) 🔁 (kubectl config set-context --current --namespace=default) → Reset namespace to default"
  kubectl config set-context --current --namespace=default
}

kns() {
  if [ -z "$1" ]; then
    echo "Usage: kns <namespace>"
    return 1
  fi
  echo "$(k8s_prefix) ✅ (kubectl config set-context --current --namespace=$1) → Switch namespace"
  kubectl config set-context --current --namespace="$1"
}

# -----------------------------------
# ☸️ Context Management
# -----------------------------------

kctx() {
  echo "$(k8s_prefix) ☸️ (kubectl config get-contexts) → List all contexts"
  kubectl config get-contexts "$@"
}

kcctx() {
  echo "$(k8s_prefix) ☸️ (kubectl config current-context) → Show current context"
  kubectl config current-context
}

ksctx() {
  if [ -z "$1" ]; then
    echo "Usage: ksctx <context-name>"
    return 1
  fi
  echo "$(k8s_prefix) ✅ (kubectl config use-context $1) → Switch to context"
  kubectl config use-context "$1"
}

# -----------------------------------
# 🔍 Combo Helpers
# -----------------------------------

kwhere() {
  echo "$(k8s_prefix) 🔍 (kubectl config current-context && kubectl config view --minify --output jsonpath={..namespace}) → Show context and namespace"
  ctx=$(kubectl config current-context 2>/dev/null || echo '-')
  ns=$(kubectl config view --minify --output 'jsonpath={..namespace}' 2>/dev/null || echo 'default')
  echo "Context: $ctx"
  echo "Namespace: $ns"
}

# -----------------------------------
# ☁️ AWS Helpers
# -----------------------------------

awswho() { echo "👤 (aws sts get-caller-identity) → Show AWS identity"; aws sts get-caller-identity; }
awsls() { echo "📦 (aws s3 ls) → List S3 buckets"; aws s3 ls; }
awsprofiles() { echo "📋 (grep '^\[' ~/.aws/config) → List configured AWS profiles"; grep "^\[" ~/.aws/config | tr -d "[]"; }
awsu() { echo "⚙️ (aws configure list) → Show AWS CLI configuration"; aws configure list; }
ekslist() { echo "☸️ (aws eks list-clusters --region eu-west-1) → List EKS clusters"; aws eks list-clusters --region eu-west-1; }
eksuse() { if [ -z "$1" ]; then echo "Usage: eksuse <cluster-name>"; return 1; fi; echo "🔄 (aws eks update-kubeconfig --region eu-west-1 --name $1) → Update kubeconfig for cluster"; aws eks update-kubeconfig --region eu-west-1 --name "$1"; }
awspubip() { echo "🌍 (curl -s https://checkip.amazonaws.com) → Show public IP"; curl -s https://checkip.amazonaws.com; }
awsswitch() { if [ -z "$1" ]; then echo "Usage: awsswitch <profile>"; return 1; fi; echo "✅ (export AWS_PROFILE=$1) → Switch AWS profile"; export AWS_PROFILE="$1"; }

# -----------------------------------
# 🧱 Terraform Helpers
# -----------------------------------

tf() { echo "🏗️ (terraform $*) → Run Terraform command"; terraform "$@"; }
tfi() { echo "📦 (terraform init) → Initialize Terraform"; terraform init "$@"; }
tfp() { echo "🧩 (terraform plan) → Show Terraform plan"; terraform plan "$@"; }
tfa() { echo "🚀 (terraform apply -auto-approve) → Apply Terraform configuration"; terraform apply -auto-approve "$@"; }
tfd() { echo "💣 (terraform destroy -auto-approve) → Destroy Terraform-managed resources"; terraform destroy -auto-approve "$@"; }
tfv() { echo "✅ (terraform validate) → Validate Terraform configuration"; terraform validate "$@"; }
tfs() { echo "📜 (terraform state list) → List resources in Terraform state"; terraform state list "$@"; }
tfws() { echo "🏷️ (terraform workspace show) → Show current workspace"; terraform workspace show "$@"; }
tfwsl() { echo "📂 (terraform workspace list) → List all workspaces"; terraform workspace list "$@"; }
tfdtarget() { if [ -z "$1" ]; then echo "Usage: tfdtarget <resource>"; return 1; fi; echo "💥 (terraform destroy -target=$1 -auto-approve) → Destroy specific resource"; terraform destroy -target="$1" -auto-approve; }

# -----------------------------------
# 🧾 Environment Summary
# -----------------------------------

devstatus() {
  echo "🧾 (kubectl config / aws identity) → Environment summary"
  echo "🕒 Date: $(date)"
  echo "👤 User: $(whoami)"
  echo "🌍 AWS Profile: ${AWS_PROFILE:-default}"
  echo "☸️ Context: $(kubectl config current-context 2>/dev/null || echo '-')"
  echo "📦 Namespace: $(kubectl config view --minify --output 'jsonpath={..namespace}' 2>/dev/null || echo 'default')"
}

# -----------------------------------
# 💡 Help / Usage Overview (with Emojis)
# -----------------------------------

khelp() {
  cat <<'EOF'

🌟  Kubectl Handy Aliases & Functions 🌟
───────────────────────────────────────────────
🚀 All commands print the context & namespace before execution:
Example:
  ☸️ eks-dev-cluster / shop -> 📦 (kubectl get pods) → List pods in current namespace

───────────────────────────────────────────────
☸️  KUBERNETES COMMANDS
───────────────────────────────────────────────
⚙️  k <args>                   → Run any kubectl command
📦  kgp                        → Get Pods in current namespace
🔌  kgs                        → Get Services in current namespace
🏷️  kgns                       → List all Namespaces
📦  kgpa                       → Get Pods across ALL namespaces
🖥️  kgn                        → Get Nodes (wide output)
🚀  kgd                        → Get Deployments
🌐  kgi                        → Get Ingress resources
📜  klo <pod> [-c container]   → Tail logs for a Pod
🔧  kex <pod> [-c container]   → Exec into a running Pod
❌  kdel <type>/<name>         → Delete a resource
🔎  kdesc <type>/<name>        → Describe a resource
📤  kapply -f <file.yaml>      → Apply manifest
✏️  kedit <type>/<name>        → Edit a resource in place

───────────────────────────────────────────────
🏷️  NAMESPACE MANAGEMENT
───────────────────────────────────────────────
🏷️  kcn                        → Show current namespace
✅  kns <namespace>            → Switch namespace
🔁  kndef                      → Reset namespace to default

───────────────────────────────────────────────
☸️  CONTEXT MANAGEMENT
───────────────────────────────────────────────
☸️  kctx                       → List all contexts
🔍  kcctx                      → Show current context
✅  ksctx <context>            → Switch context
🧭  kwhere                     → Show current context + namespace

───────────────────────────────────────────────
☁️  AWS COMMANDS
───────────────────────────────────────────────
👤  awswho                    → Show current AWS identity
📋  awsprofiles               → List configured AWS profiles
⚙️  awsu                      → Show AWS CLI config
🌍  awspubip                  → Show public IP address
🔄  awsswitch <profile>       → Switch AWS CLI profile
☸️  ekslist                   → List EKS clusters (eu-west-1)
🔄  eksuse <cluster>          → Update kubeconfig for EKS cluster

───────────────────────────────────────────────
🧱  TERRAFORM COMMANDS
───────────────────────────────────────────────
🏗️  tf <args>                 → Run Terraform command
📦  tfi                       → terraform init
🧩  tfp                       → terraform plan
🚀  tfa                       → terraform apply -auto-approve
💣  tfd                       → terraform destroy -auto-approve
✅  tfv                       → terraform validate
📜  tfs                       → terraform state list
🏷️  tfws                      → terraform workspace show
📂  tfwsl                     → terraform workspace list
💥  tfdtarget <resource>      → Destroy a specific resource

───────────────────────────────────────────────
🧾  SYSTEM & INFO COMMANDS
───────────────────────────────────────────────
🧾  devstatus                 → Show AWS profile, context, namespace
💡  khelp                     → Display this help guide

───────────────────────────────────────────────
🪄  EXAMPLES
───────────────────────────────────────────────
🔹  kgn                       → Show nodes
🔹  kgp                       → Show pods in current namespace
🔹  kns dev                   → Switch to namespace "dev"
🔹  ksctx prod                → Switch to context "prod"
🔹  eksuse my-cluster         → Load kubeconfig for "my-cluster"
🔹  tfp                       → Terraform plan
🔹  tfa                       → Terraform apply
🔹  tfd                       → Terraform destroy
🔹  devstatus                 → Quick environment summary

───────────────────────────────────────────────
✨  Tip:
All K8s commands automatically prefix with your current context & namespace.
This keeps you safe from running in the wrong cluster.
──────────────────────────────────────────────

EOF
}
