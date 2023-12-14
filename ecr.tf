# Resource block
resource "aws_ecr_repository" "ecr_private" {
  count                = var.create_ecr_repository_public ? 0 : 1
  name                 = var.ecr_repository_name
  image_tag_mutability = var.ecr_image_tag_mutability

  image_scanning_configuration {
    scan_on_push = var.ecr_scan_on_push
  }
}
resource "aws_ecrpublic_repository" "ecr_public" {
  count           = var.create_ecr_repository_public ? 1 : 0
  repository_name = var.ecr_repository_name
  provider        = aws.us-east-1
}

resource "aws_ecr_repository_policy" "ecr" {
  count      = var.allowed_account_ids != null ? 1 : 0
  repository = var.create_ecr_repository_public ? aws_ecrpublic_repository.ecr_public[0].repository_name : aws_ecr_repository.ecr_private[0].name
  policy     = data.aws_iam_policy_document.ecr_policy[count.index].json
}

resource "aws_ecr_repository_policy" "ecr_organization" {
  count      = var.org_id != "" ? 1 : 0
  repository = var.create_ecr_repository_public ? aws_ecrpublic_repository.ecr_public[0].repository_name : aws_ecr_repository.ecr_private[0].name
  policy     = data.aws_iam_policy_document.ecr_policy_organization[count.index].json
}
