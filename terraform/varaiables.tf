# ==========================================
# == Required Variables
# ==========================================

# N/A

# ==========================================
# == Optional Variables
# ==========================================

variable "aws_region" {
  description = "The region in which to deploy resource to"
  type        = string
  default     = "ap-southeast-2"
}

variable "repository" {
  description = "This git repositories name"
  type        = string
  default     = "stack-1"
}

variable "managed_by" {
  description = "The resource responsible for managing these assets"
  type        = string
  default     = "terraform"
}
