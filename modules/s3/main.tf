#
resource "aws_s3_bucket" "weatherappbucket" {
  bucket = var.bucket
  acl    = "private"
}
