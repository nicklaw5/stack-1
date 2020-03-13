resource "aws_s3_bucket" "tf_state_artifacts_bucket" {
  bucket = "tf-state-artifacts-bucket"
  acl    = "private"
  region = var.aws_region

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  tags = {
    Name       = "tf-state-artifacts-bucket"
    Repository = var.repository
    ManagedBy  = var.managed_by
  }
}
