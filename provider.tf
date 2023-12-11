data "aws_caller_identity" "current" {}

provider "aws" {
  region = var.region
  alias  = "us-east-1"  # Replace with a meaningful alias
}
