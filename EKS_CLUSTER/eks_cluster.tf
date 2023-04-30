resource "aws_eks_cluster" "demo-eks-cluster" {
  name     = "demo-eks-cluster"
  role_arn = aws_iam_role.eks-role.arn
  vpc_config {
    subnet_ids = data.aws_subnets.subnets.ids
  }
}

resource "aws_iam_role" "eks-role" {
  name = "eks-role"
  managed_policy_arns = ["arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"]
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "eks.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })
}


data "aws_subnets" "subnets" {}



