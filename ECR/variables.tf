# Default variables
variable "ecr_repository_name" {
  description = "The name of the ECR repository"
  type        = string
  default     = "example"
}

variable "ecr_image_tag_mutability" {
  description = "The mutability of image tags in the repository"
  type        = string
  default     = "MUTABLE"
}

variable "ecr_scan_on_push" {
  description = "Enable or disable image scanning on push"
  type        = bool
  default     = true
}
variable "create_ecr_repository_private" {
  description = "Whether to create the ECR repository"
  type        = bool
  default     = false
}
variable "create_ecr_repository_public" {
  description = "Whether to create the ECR repository"
  type        = bool
  default     = false
}
variable "allowed_account_ids" {
  description = "List of AWS account IDs allowed to perform actions"
  type        = list(string)
  default     = ["123456789012"]
}

variable "create_ecr_repository_policy" {
  description = "Whether to create the ECR repository policy"
  type        = bool
  default     = false
}
variable "ecr_lifecycle_policy_expire" {
  description = "Whether to create the ECR lifecycle policy of expire"
  type        = bool
  default     = false
}
variable "ecr_lifecycle_policy_images" {
  description = "Whether to create the ECR lifecycle policy of limit images"
  type        = bool
  default     = false
}
variable "expire_after_days" {
  description = "Number of days after which images will be expired"
  type        = number
  default     = 14
}
variable "number_images" {
  description = "Number of limit images"
  type        = number
  default     = 14
}
