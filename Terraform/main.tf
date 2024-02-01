# main.tf

provider "aws" {
  region = "ap-south-1"  
}

resource "aws_vpc" "example_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "VPC_APSouth-1"
  }
}

resource "aws_subnet" "example" {
  vpc_id            = data.aws_vpc.selected.id
  availability_zone = "us-west-2a"
  cidr_block        = cidrsubnet(data.aws_vpc.selected.cidr_block, 4, 1)
}


module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = "app1-cluster"
  subnets         = aws_subnet.example
  vpc_id          = "aws_vpc.example_vpc.id"  # Replace with your own VPC ID
  cluster_version = "1.28"  # Change to your desired Kubernetes version
}

output "kubeconfig" {
  value = module.eks.kubeconfig
}

output "config_map_aws_auth" {
  value = module.eks.config_map_aws_auth.
  
}
