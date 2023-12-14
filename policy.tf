resource "aws_ecr_lifecycle_policy" "ecr_expire" {
  count      = var.expire_after_days > 0 ? 1 : 0
  repository = var.create_ecr_repository_public ? aws_ecrpublic_repository.ecr_public[0].repository_name : aws_ecr_repository.ecr_private[0].name

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
  count      = var.number_images > 0 ? 1 : 0
  repository = var.create_ecr_repository_public ? aws_ecrpublic_repository.ecr_public[0].repository_name : aws_ecr_repository.ecr_private[0].name
  policy     = <<EOF
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
  count = var.allowed_account_ids != null ? 1 : 0
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

data "aws_iam_policy_document" "ecr_policy_organization" {
  count = var.org_id != "" ? 1 : 0

  statement {
    sid    = "${var.ecr_repository_name}-ecr-policy"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = [
      "ecr:BatchCheckLayerAvailability",
      "ecr:BatchGetImage",
      "ecr:CompleteLayerUpload",
      "ecr:GetDownloadUrlForLayer",
      "ecr:InitiateLayerUpload",
      "ecr:PutImage",
      "ecr:SetRepositoryPolicy",
      "ecr:UploadLayerPart"
    ]
    condition {
      test     = "StringEquals"
      variable = "aws:PrincipalOrgID"
      values   = [var.org_id]
    }
  }
}
