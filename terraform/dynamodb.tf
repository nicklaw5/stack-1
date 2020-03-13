resource "aws_dynamodb_table" "tf_state_table" {
  name         = "tf-state-table"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name       = "tf-state-table"
    Repository = var.repository
    ManagedBy  = var.managed_by
  }
}
