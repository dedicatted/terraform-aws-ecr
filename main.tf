module "ecr" {
  source = "./ECR"
  create_ecr_repository_public = true
  ecr_lifecycle_policy_expire = true
  expire_after_days = 3
}
