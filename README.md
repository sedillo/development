# Chicken vs The Egg

There will always be an issue of how to setup a development system, which turns into a chicken and an egg issue.

For now we 
* Provision with Terraform assuming some tools already are installed (out of scope)
* Install Ansible
* Run playbook to install tools needed to run a Terraform playbook

# Provision with Terraform

Execute the code below which will setup a terrafrom instance

```bash
# Creating Keys (Only needed 1st time)
export FILE=aws_key3
ssh-keygen -t rsa -b 2048 -f $FILE

# Setting Variables
export FILE=aws_key3
export TF_VAR_ssh_public_key=$(cat $FILE.pub)

# AWS Vals
export AWS_ACCESS_KEY_ID=$(aws configure get aws_access_key_id)
export AWS_SECRET_ACCESS_KEY=$(aws configure get aws_secret_access_key)

# Terraform 
terraform apply -auto-approve
PUBLIC_IP=$(terraform output instance_ip_addr | tr -d '"')
# Test auto connect
ssh -i $FILE -o "StrictHostKeyChecking no" $PUBLIC_IP
```

# Now that you can login setup your environment

[Kubectl Install](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/)

```bash
# General
sudo apt-get update && sudo apt-get upgrade -y

# Kubectl Download
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
curl -LO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"

# Verify download checksum
echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check

# Install
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
```

