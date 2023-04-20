## this modules are from terraform registry

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "4.0.1"
}

module "iam_iam-user" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-user"
  version = "3.4.0"
  # insert the 1 required variable here
}