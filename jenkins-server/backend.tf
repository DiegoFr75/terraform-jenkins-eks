terraform {
  backend "s3" {
    bucket = "eks-jenkins-terraform-state"
    key    = "jenkins/terraform.tfstate"
    region = "us-east-1"
  }
}