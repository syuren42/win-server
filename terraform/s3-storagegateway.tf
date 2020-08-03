resource "aws_s3_bucket" "storage-gatway" {
  bucket = "storage-gatway"
  acl    = "private"
  #  policy = data.aws_iam_policy_document.storage-gatway.json

  lifecycle {
    prevent_destroy = false
  }
}

resource "aws_s3_bucket_public_access_block" "storage-gatway" {
  bucket                  = aws_s3_bucket.storage-gatway.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

