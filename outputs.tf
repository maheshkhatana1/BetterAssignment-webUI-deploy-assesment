output "cluster_name" {
value = module.eks.cluster_id
}


output "cluster_endpoint" {
value = module.eks.cluster_endpoint
}


output "kubeconfig-cmd" {
value = "aws eks update-kubeconfig --region ${var.aws_region} --name ${module.eks.cluster_name}"
}
