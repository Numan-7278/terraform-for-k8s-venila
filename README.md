# terraform-for-k8s-venila

# Provider.tf 
contains information about cloud provider and hashicop information.

# variables.tf 
contains information about the requirements to configure ec2 not hardcoded only type of data take as information

# terraform.tfvar
contains actual information and values of variables that required to lunch ec2

# main.tf 
actual HCL 

# outputs.tf
after creation what you want to print as a result
# run on master after connecting 

sudo kubectl get pods -n kube-system

# Get join command for workers

sudo kubeadm token create --print-join-command
(Paste on all workers)

kubectl get nodes
