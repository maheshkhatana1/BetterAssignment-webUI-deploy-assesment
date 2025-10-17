variable "aws_region" {
description = "AWS region"
type = string
default = "us-east-1"
}


variable "cluster_name" {
description = "EKS cluster name"
type = string
default = "openwebui-cluster"
}


variable "node_group_desired_capacity" {
type = number
default = 2
}


variable "node_instance_type" {
type = string
default = "t3.large"
}
