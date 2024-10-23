provider "aws"{
    region= var.region  
    profile="test"
   }

terraform {
  required_providers {
    archive = {
      source  = "hashicorp/archive"
      version = "~> 2.5.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.66.0"
    }
  }
   backend "s3" {
    bucket  = "raz-terraform-state"
    key     = "terraform.tfstate"
    region  = "us-east-2"

    
     
  }
}