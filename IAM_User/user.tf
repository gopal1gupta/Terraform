provider "aws" {
  region = "ap-south-1"
  access_key = "jfjkkk"
  secret_key = "fffff"
//  note: you can give key and id in form of aws configure
//  or in form of env variables:
//    export AWS_ACCESS_KEY_ID =
//    export AWS_SECRET_ACCESS_KEY_ID=
//      export AWS_REGION = ap-south-1
//  if we set all these env varibale then, we wont be needing provider block
}
## creating a user
resource "aws_iam_user" "admin-user" {
  name = "Gopal"
  tags={
    Description = " devops engineer"
  }
}

## Creating a policy
resource "aws_iam_policy" "adminuser" {
  name = "adminusers"
  policy = <<EOF
   {
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "*",
            "Resource": "*"
        }
    ]
   }
  EOF
}

# above policy can be attached using this also
resource "aws_iam_policy" "adminuser" {
  name = "adminusers"
  policy = file("admin-policy.json")
}

## attaching a policy to the user
resource "aws_iam_user_policy_attachment" "gopal-admin-access" {
  policy_arn = aws_iam_policy.adminuser.arn
  user = aws_iam_user.admin-user.name
}

## suppose i want to create multiple user
resource "aws_iam_user" "users" {
    name = var.project-sapphire-users[count.index]

    count=length(var.project-sapphire-users)

}