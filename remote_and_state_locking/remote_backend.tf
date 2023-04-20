## here we need two thing first s3 bucket to store tfstate file and
## dynamodb table for state locking

terraform {  ## apply terraform init so that new backend can be initialized
  backend "s3" {
    bucket = "bucket-name"
    key = "statefile/terraform.tfstate"
    region = "ap-south-1"
    dynamodb_table = "state-locking"
  }
}

## when you run this command your state file will be upload to s3 if there is already state file