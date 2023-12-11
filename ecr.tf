# Resource block
resource "aws_ecr_repository" "ecr_private" {
  count                = var.create_ecr_repository_private ? 1 : 0
  name                 = var.ecr_repository_name
  image_tag_mutability = var.ecr_image_tag_mutability

  image_scanning_configuration {
    scan_on_push = var.ecr_scan_on_push
  }
}
resource "aws_ecrpublic_repository" "ecr_public" {
  count           = var.create_ecr_repository_public ? 1 : 0
  repository_name = var.ecr_repository_name
}

resource "aws_ecr_repository_policy" "ecr" {
  count      = (var.create_ecr_repository_public && var.create_ecr_repository_policy) || (var.create_ecr_repository_private && var.create_ecr_repository_policy) ? 1 : 0
  repository = element(concat(aws_ecrpublic_repository.ecr_public[*].name, aws_ecr_repository.ecr_private[*].name), count.index)
  policy     = data.aws_iam_policy_document.ecr_policy[count.index].json
}
