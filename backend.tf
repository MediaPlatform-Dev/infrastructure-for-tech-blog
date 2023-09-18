terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.36"
    }
  }

  #backend s3 {
  #  bucket = "tech-blog-terraform-state"
  #  key = "terraform/terraform.tfstate"
  #  region = "ap-northeast-2"
  #  dynamodb_table = "terraform-state-lock"
  #}
}