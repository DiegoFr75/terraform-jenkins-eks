# VPC
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.14.0"

  name = "eks-vpc"
  cidr = var.vpc_cidr

  azs             = data.aws_availability_zones.azs.names
  public_subnets  = var.public_subnet
  private_subnets = var.private_subnet

  enable_dns_hostnames = true
  enable_nat_gateway   = true
  single_nat_gateway   = true

  tags = {
    Name        = "eks-vpc"
    Terraform   = "true"
    Environment = "dev"
    "kubernetes.io/cluster/my-eks-cluster" : "shared"
  }

  public_subnet_tags = {
    Name = "eks-public-subnet"
    "kubernetes.io/cluster/my-eks-cluster" : "shared"
    "kubernetes.io/role/elb" : 1
  }

  private_subnet_tags = {
    Name = "eks-private-subnet"
    "kubernetes.io/cluster/my-eks-cluster" : "shared"
    "kubernetes.io/role/internal-elb" : 1
  }

  public_route_table_tags = {
    Name = "eks-public-rt"
  }

  private_route_table_tags = {
    Name = "eks-private-rt"
  }
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.26.1"

  cluster_endpoint_public_access = true

  cluster_name    = "my-eks-cluster"
  cluster_version = "1.24"

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  eks_managed_node_groups = {
    nodes = {
      instance_types = ["t2.small"]

      min_size     = 1
      max_size     = 3
      desired_size = 2
    }
  }

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}