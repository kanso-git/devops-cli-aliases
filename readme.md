# 🚀 DevOps CLI Aliases

A collection of powerful **command-line aliases** for **Kubernetes**, **AWS**, and **Terraform**, designed to make DevOps workflows faster, safer, and more consistent.

> 🧠 All commands automatically print your current **Kubernetes context** and **namespace** before execution — keeping you safe from running commands in the wrong cluster.

---

## ⚡ Features

✅ Simplifies repetitive CLI tasks
✅ Works across Kubernetes, AWS, and Terraform
✅ Adds safety by showing context before running K8s commands
✅ Boosts productivity for DevOps engineers and developers
✅ Easy to install and share across your team

---

## 📦 Installation

Clone the repository:

```bash
git clone https://github.com/kanso-git/devops-cli-aliases.git
cd devops-cli-aliases
```

Then **source the aliases** in your shell startup file:

### For Bash:

```bash
echo "source ~/devops-cli-aliases/devops-aliases.sh" >> ~/.bashrc
source ~/.bashrc
```

### For Zsh:

```bash
echo "source ~/devops-cli-aliases/devops-aliases.sh" >> ~/.zshrc
source ~/.zshrc
```

That’s it! 🎉
Now you can use all commands instantly.

---

## 🧩 Example Usage

```bash
kgp              # Get pods in the current namespace
kns dev          # Switch to the 'dev' namespace
ksctx prod       # Switch to the 'prod' context
eksuse clusterA  # Update kubeconfig for EKS clusterA
tfp              # Run Terraform plan
devstatus        # Show AWS profile, context, and namespace
```

---

## 🪄 Available Commands

### ☸️ Kubernetes

| Icon | Alias                   | Description                       |
| ---- | ----------------------- | --------------------------------- |
| ⚙️   | `k <args>`              | Run any kubectl command           |
| 📦   | `kgp`                   | Get Pods in current namespace     |
| 🔌   | `kgs`                   | Get Services in current namespace |
| 🏷️   | `kgns`                  | List all Namespaces               |
| 📦   | `kgpa`                  | Get Pods across ALL namespaces    |
| 🖥️   | `kgn`                   | Get Nodes (wide output)           |
| 🚀   | `kgd`                   | Get Deployments                   |
| 🌐   | `kgi`                   | Get Ingress resources             |
| 📜   | `klo <pod>`             | Tail logs for a Pod               |
| 🔧   | `kex <pod>`             | Exec into a running Pod           |
| ❌   | `kdel <type>/<name>`    | Delete a resource                 |
| 🔎   | `kdesc <type>/<name>`   | Describe a resource               |
| 📤   | `kapply -f <file.yaml>` | Apply manifest                    |
| ✏️   | `kedit <type>/<name>`   | Edit a resource in place          |

---

### ☁️ AWS

| Icon | Alias                 | Description                       |
| ---- | --------------------- | --------------------------------- |
| 👤   | `awswho`              | Show current AWS identity         |
| 📋   | `awsprofiles`         | List configured AWS profiles      |
| ⚙️   | `awsu`                | Show AWS CLI config               |
| 🌍   | `awspubip`            | Show public IP address            |
| 🔄   | `awsswitch <profile>` | Switch AWS CLI profile            |
| ☸️   | `ekslist`             | List EKS clusters                 |
| 🔄   | `eksuse <cluster>`    | Update kubeconfig for EKS cluster |

---

### 🧱 Terraform

| Icon | Alias                  | Description                       |
| ---- | ---------------------- | --------------------------------- |
| 🏗️   | `tf <args>`            | Run Terraform command             |
| 📦   | `tfi`                  | `terraform init`                  |
| 🧩   | `tfp`                  | `terraform plan`                  |
| 🚀   | `tfa`                  | `terraform apply -auto-approve`   |
| 💣   | `tfd`                  | `terraform destroy -auto-approve` |
| ✅   | `tfv`                  | `terraform validate`              |
| 📜   | `tfs`                  | `terraform state list`            |
| 🏷️   | `tfws`                 | `terraform workspace show`        |
| 📂   | `tfwsl`                | `terraform workspace list`        |
| 💥   | `tfdtarget <resource>` | Destroy a specific resource       |

---

### 🧾 System & Info

| Icon | Alias       | Description                          |
| ---- | ----------- | ------------------------------------ |
| 🧾   | `devstatus` | Show AWS profile, context, namespace |
| 💡   | `khelp`     | Display this help guide              |

---

## 🪄 Tip

Every Kubernetes command is prefixed with your **current context** and **namespace**, for example:

```
☸️  eks-dev-cluster / shop -> 📦 (kubectl get pods)
```

---

## 🧠 Bonus: Productivity Tip

If you work on multiple environments:

* Create a `.devops-aliases.local.sh` file with your own shortcuts
* Source it *after* the main file for overrides:

  ```bash
  source ~/devops-cli-aliases/devops-aliases.sh
  source ~/devops-cli-aliases/devops-aliases.local.sh
  ```

---

## 🛠️ Requirements

* **kubectl**
* **aws CLI**
* **terraform**
* A Unix-like shell (Bash, Zsh, Fish)

---

## 🤝 Contributing

Contributions are welcome!
If you have an idea for a new alias or improvement:

1. Fork the repo
2. Add your alias
3. Submit a PR

---

## 📜 License

MIT License — free to use, modify, and share.

---

## 🌟 Author

Created by **www.experts-lab.com** — DevOps Lead, automation enthusiast, and CLI advocate.

> *Because great engineers don’t just click — they command.*

---
