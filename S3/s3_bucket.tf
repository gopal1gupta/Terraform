resource "aws_s3_bucket" "finance" {
  bucket = "gopalguptabucket" ## note bucket name should be unique

}

## to upload file(object) into s3
resource "aws_s3_object" "finance2000" {
  bucket = aws_s3_bucket.finance.id
  key = "finance.txt"
  content = "/root/finacce.txt"
}

## bucket policy

data "aws_iam_group" "finance-data" {
  group_name = "finance-analysts"
}

resource "aws_s3_bucket_policy" "finance-policy" {
  bucket = aws_s3_bucket.finance.id
  policy = <<EOF {
  json file
  "resource":"arn:aws:s3::${aws_s3_bucket.finance.is}/*",
  "priciple":{
             "aws":{${data.aws_iam_group.finance-data.arn}

}
