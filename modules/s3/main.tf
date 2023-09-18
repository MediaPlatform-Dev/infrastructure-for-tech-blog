resource "aws_s3_bucket" "this" {
  bucket = "${var.tags.Project}-${var.bucket}"

  lifecycle {
    prevent_destroy = true
  }

  tags = merge(
    {
      Name = "s3-${var.tags.Project}-${var.bucket}"
      Type = "s3"
    },
    var.tags
  )
}

resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id
  versioning_configuration {
    status = "Enabled"
  }
}