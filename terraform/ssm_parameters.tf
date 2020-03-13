resource "aws_ssm_parameter" "terraform_lock_table" {
  name      = "/${var.repository}/terraform_lock_table"
  type      = "String"
  value     = aws_dynamodb_table.tf_state_table.id
  overwrite = true
}

resource "aws_ssm_parameter" "terraform_state_bucket" {
  name      = "/${var.repository}/terraform_state_bucket"
  type      = "String"
  value     = aws_s3_bucket.tf_state_artifacts_bucket.id
  overwrite = true
}
