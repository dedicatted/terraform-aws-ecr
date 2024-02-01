# Overview
This Terraform module, `terraform-aws-ecr`, is designed to simplify the management of AWS Elastic Container Registry (ECR) resources. It provides a declarative way to create and manage ECR repositories, allowing you to efficiently handle container images in your AWS environment.

## Features
- **Repository Creation**: Easily create and manage ECR repositories to store and organize container images.
- **Access Control**: Define granular access policies to regulate who can interact with your ECR repositories.
- **Lifecycle Policies**: Implement lifecycle policies to automate the cleanup of old and unused images.


## Usage

To create private repository

```
module "ecr" {
  source = "github.com/dedicatted/terraform-aws-ecr"
}

```
To create public repository. Public repository only creates in region *us-east-1*

```
module "ecr" {
  source = "github.com/dedicatted/terraform-aws-ecr"
  create_ecr_repository_public = true
}

```

To add a policy of expire and limits on images

```
module "ecr" {
  source = "github.com/dedicatted/terraform-aws-ecr"
  number_images = 12
  expire_after_days = 30
}
```

To give permissions to some AWS users

```
module "ecr" {
  source = "github.com/dedicatted/terraform-aws-ecr"
  allowed_account_ids = ["123456789", "123456789"]
}
```

To create organization access
```
module "ecr" {
  source = "github.com/dedicatted/terraform-aws-ecr"
  org_id = "123456789"
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.47 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.30.0 |
| <a name="provider_aws.us-east-1"></a> [aws.us-east-1](#provider\_aws.us-east-1) | 5.30.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ecr_lifecycle_policy.ecr_expire](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_lifecycle_policy) | resource |
| [aws_ecr_lifecycle_policy.ecr_policy_images](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_lifecycle_policy) | resource |
| [aws_ecr_repository.ecr_private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository) | resource |
| [aws_ecr_repository_policy.ecr](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository_policy) | resource |
| [aws_ecr_repository_policy.ecr_organization](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository_policy) | resource |
| [aws_ecrpublic_repository.ecr_public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecrpublic_repository) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.ecr_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.ecr_policy_organization](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allowed_account_ids"></a> [allowed\_account\_ids](#input\_allowed\_account\_ids) | List of AWS account IDs allowed to perform actions | `list(string)` | `null` | no |
| <a name="input_create_ecr_repository_public"></a> [create\_ecr\_repository\_public](#input\_create\_ecr\_repository\_public) | Whether to create the ECR repository | `bool` | `false` | no |
| <a name="input_ecr_image_tag_mutability"></a> [ecr\_image\_tag\_mutability](#input\_ecr\_image\_tag\_mutability) | The mutability of image tags in the repository | `string` | `"MUTABLE"` | no |
| <a name="input_ecr_repository_name"></a> [ecr\_repository\_name](#input\_ecr\_repository\_name) | The name of the ECR repository | `string` | `"example"` | no |
| <a name="input_ecr_scan_on_push"></a> [ecr\_scan\_on\_push](#input\_ecr\_scan\_on\_push) | Enable or disable image scanning on push | `bool` | `true` | no |
| <a name="input_expire_after_days"></a> [expire\_after\_days](#input\_expire\_after\_days) | Number of days after which images will be expired | `number` | `0` | no |
| <a name="input_number_images"></a> [number\_images](#input\_number\_images) | Number of limit images | `number` | `0` | no |
| <a name="input_org_id"></a> [org\_id](#input\_org\_id) | AWS organization ID allowed to perform actions | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_private_repository_url"></a> [private\_repository\_url](#output\_private\_repository\_url) | URL of the private ECR repository |
| <a name="output_public_repository_url"></a> [public\_repository\_url](#output\_public\_repository\_url) | URL of the public ECR repository |
