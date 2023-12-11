## Usage

To create a private repository

```
module "ecr" {
  source = "github.com/dedicatted/terraform-aws-ecr"
  create_ecr_repository_private = true
}
```
To create a public repository

```
module "ecr" {
  source = "./ECR"
  create_ecr_repository_public = true
}
```
To allow permission for other accounts
```
module "ecr" {
  source = "github.com/dedicatted/terraform-aws-ecr"
  create_ecr_repository_public = true
  create_ecr_repository_policy = true
  allowed_account_ids = ["122222221", "99999999"]
}
```
To create organization access
```
module "ecr" {
  source = "github.com/dedicatted/terraform-aws-ecr"
  create_ecr_repository_public = true
  create_organization_policy = true
  org_id = "11111111"
}
```
To add expire policy
```
module "ecr" {
  source = "github.com/dedicatted/terraform-aws-ecr"
  create_ecr_repository_public = true
  ecr_lifecycle_policy_expire = true
  expire_after_days = 3
}
```

To add limitation on images in repository
```
module "ecr" {
  source = "github.com/dedicatted/terraform-aws-ecr"
  create_ecr_repository_public = true
  ecr_lifecycle_policy_images = true
  number_images = 31
}

```




## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.29.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ecr_lifecycle_policy.ecr_expire](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_lifecycle_policy) | resource |
| [aws_ecr_lifecycle_policy.ecr_policy_images](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_lifecycle_policy) | resource |
| [aws_ecr_repository.ecr_private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository) | resource |
| [aws_ecr_repository.ecr_public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository) | resource |
| [aws_ecr_repository_policy.ecr](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository_policy) | resource |
| [aws_iam_policy_document.ecr_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allowed_account_ids"></a> [allowed\_account\_ids](#input\_allowed\_account\_ids) | List of AWS account IDs allowed to perform actions | `list(string)` | <pre>[<br>  "123456789012"<br>]</pre> | no |
| <a name="input_create_ecr_repository_policy"></a> [create\_ecr\_repository\_policy](#input\_create\_ecr\_repository\_policy) | Whether to create the ECR repository policy | `bool` | `false` | no |
| <a name="input_create_ecr_repository_private"></a> [create\_ecr\_repository\_private](#input\_create\_ecr\_repository\_private) | Whether to create the ECR repository | `bool` | `false` | yes |
| <a name="input_create_ecr_repository_public"></a> [create\_ecr\_repository\_public](#input\_create\_ecr\_repository\_public) | Whether to create the ECR repository | `bool` | `false` | yes |
| <a name="input_ecr_image_tag_mutability"></a> [ecr\_image\_tag\_mutability](#input\_ecr\_image\_tag\_mutability) | The mutability of image tags in the repository | `string` | `"MUTABLE"` | no |
| <a name="input_ecr_lifecycle_policy_expire"></a> [ecr\_lifecycle\_policy\_expire](#input\_ecr\_lifecycle\_policy\_expire) | Whether to create the ECR lifecycle policy of expire | `bool` | `false` | no |
| <a name="input_ecr_lifecycle_policy_images"></a> [ecr\_lifecycle\_policy\_images](#input\_ecr\_lifecycle\_policy\_images) | Whether to create the ECR lifecycle policy of limit images | `bool` | `false` | no |
| <a name="input_create_organization_policy"></a> [create\_organization\_policy](#input\_ecr\_lifecycle\_policy) | Whether to create the ECR organization policy | `bool` | `false` | no |
| <a name="input_ecr_repository_name"></a> [ecr\_repository\_name](#input\_ecr\_repository\_name) | The name of the ECR repository | `string` | `"example"` | no |
| <a name="input_ecr_scan_on_push"></a> [ecr\_scan\_on\_push](#input\_ecr\_scan\_on\_push) | Enable or disable image scanning on push | `bool` | `true` | no |
| <a name="input_expire_after_days"></a> [expire\_after\_days](#input\_expire\_after\_days) | Number of days after which images will be expired | `number` | `14` | no |
| <a name="input_number_images"></a> [number\_images](#input\_number\_images) | Number of limit images | `number` | `14` | no |
| <a name="input_org_id"></a> [org\_id](#input\_org\_id) | AWS organization ID allowed to perform actions | `string` | `123456789012` | no |


## Outputs

No outputs.
