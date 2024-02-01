output "private_repository_url" {
  value       = var.create_ecr_repository_public ? null : aws_ecr_repository.ecr_private[0].repository_url
  description = "URL of the private ECR repository"

}

output "public_repository_url" {
  value       = var.create_ecr_repository_public ? aws_ecrpublic_repository.ecr_public[0].repository_uri : null
  description = "URL of the public ECR repository"
}
