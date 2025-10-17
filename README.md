
"# BetterAssignment-webUI-deploy-repo" 


This repository contains a ready-to-deploy project to provision an AWS EKS cluster with Terraform, and Kubernetes manifests to run Ollama and Open WebUI and connect them. The Terraform portion creates the EKS cluster and nodegroup. Kubernetes manifests are applied manually with kubectl .

# Open WebUI + Ollama on AWS EKS


## Overview
This repo provisions an AWS EKS cluster (Terraform) and provides Kubernetes manifests to deploy Ollama and Open WebUI. The two connect inside the cluster using a ClusterIP service for Ollama and Open WebUI pointing to it.


## Prerequisites
- AWS account with permissions to create VPC, EKS, IAM, EC2
- AWS CLI configured (`aws configure`)
- Terraform 1.5+
- kubectl


## Deployment (high-level)
1. Edit `terraform/variables.tf` or pass vars to `terraform apply`.
2. From `terraform/`:
```bash
terraform init
terraform apply -auto-approve



3.Update kubeconfig (replace variables or use outputs):
aws eks update-kubeconfig --region $AWS_REGION --name $cluster_name

4.From repo root, apply k8s manifests:
kubectl apply -f k8s/ollama-deployment.yaml
kubectl apply -f k8s/open-webui-deployment.yaml

5.Pull a lightweight model into Ollama (exec to Ollama pod/container):
# wait for ollama pod to be Ready, then:
kubectl exec -it deploy/ollama -- ollama pull llama2

If ollama CLI differs in the image you used, adapt accordingly. llama2 is an example model alias — use a model name available to your Ollama runtime.

6.Get the Open WebUI external address:
kubectl get svc open-webui
Visit http://<EXTERNAL-IP> and interact with the web UI.






