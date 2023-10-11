# S3 Bucket for terraform backend
resource "aws_s3_bucket" "backend" {
  bucket = "bootcamp32-${lower(var.env)}-${random_integer.backend.result}"

  tags = {
    name        = "my backend"
    Environment = "Dev"
  }
}

# kms key for bucket encryption
resource "aws_kms_key" "my_key" {
  description             = "This key is used to encrypt bucket objects"
  deletion_window_in_days = 10
}

resource "aws_s3_bucket_server_side_encryption_configuration" "backend_encryption" {
  bucket = aws_s3_bucket.backend.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.my_key.arn
      sse_algorithm     = "aws:kms"
    }
  }
}



# Random integer for bucket naming convention
resource "random_integer" "backend" {
  min = 1
  max = 100
  keepers = {
    Environment = var.env
  }
}

resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.backend.id
  versioning_configuration {
    status = var.versioning
  }
}
