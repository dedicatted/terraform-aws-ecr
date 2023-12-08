resource "aws_ecr_lifecycle_policy" "ecr_expire" {
  count = (var.create_ecr_repository_public && var.ecr_lifecycle_policy_expire) || (var.create_ecr_repository_private && var.ecr_lifecycle_policy_expire) ? 1 : 0
  repository = element(concat(aws_ecrpublic_repository.ecr_public[*].name, aws_ecr_repository.ecr_private[*].name), count.index)

  policy = <<EOF
  {
      "rules": [
          {
              "rulePriority": 1,
              "description": "Expire images older than ${var.expire_after_days} days",
              "selection": {
                  "tagStatus": "untagged",
                  "countType": "sinceImagePushed",
                  "countUnit": "days",
                  "countNumber": ${var.expire_after_days}
              },
              "action": {
                  "type": "expire"
              }
          }
      ]
  }
EOF
}

resource "aws_ecr_lifecycle_policy" "ecr_policy_images" {
  count = (var.create_ecr_repository_public && var.ecr_lifecycle_policy_images) || (var.create_ecr_repository_private && var.ecr_lifecycle_policy_images) ? 1 : 0
  repository = element(concat(aws_ecrpublic_repository.ecr_public[*].name, aws_ecr_repository.ecr_private[*].name), count.index)

  policy = <<EOF
{
    "rules": [
        {
            "rulePriority": 1,
            "description": "Keep last ${var.number_images} images",
            "selection": {
                "tagStatus": "tagged",
                "tagPrefixList": ["v"],
                "countType": "imageCountMoreThan",
                "countNumber": ${var.number_images}
            },
            "action": {
                "type": "expire"
            }
        }
    ]
}
EOF
}

data "aws_iam_policy_document" "ecr_policy" {
  count = (var.create_ecr_repository_public && var.create_ecr_repository_policy) || (var.create_ecr_repository_private && var.create_ecr_repository_policy) ? 1 : 0

  statement {
    sid    = "new policy"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = var.allowed_account_ids
    }

    actions = [
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "ecr:BatchCheckLayerAvailability",
      "ecr:PutImage",
      "ecr:InitiateLayerUpload",
      "ecr:UploadLayerPart",
      "ecr:CompleteLayerUpload",
      "ecr:DescribeRepositories",
      "ecr:GetRepositoryPolicy",
      "ecr:ListImages",
      "ecr:DeleteRepository",
      "ecr:BatchDeleteImage",
      "ecr:SetRepositoryPolicy",
      "ecr:DeleteRepositoryPolicy",
    ]
  }
}
