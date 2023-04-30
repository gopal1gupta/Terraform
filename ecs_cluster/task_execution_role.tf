# https://copyprogramming.com/howto/error-creating-iam-role-malformedpolicydocument-has-prohibited-field-resource-terraform
# https://stackoverflow.com/questions/63437675/task-execution-iam-role-in-terraform
# https://spacelift.io/blog/how-to-destroy-terraform-resources
# ---------------------------------------------------------------------------------------------------------------------

## this is the role created for ecs with attached policy

resource "aws_iam_role" "task_role" {
  name                = "ecstaskrole"
  managed_policy_arns = ["arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"]
  ## directly policy arn can be used instead of defining it and attaching it

  assume_role_policy = jsonencode({ ## it is basically trusted entity means for which aws resource u wanna defined role
    "Version" : "2012-10-17",       ## donot attach policies here
    "Statement" : [
      {
        "Sid" : "",
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "ecs-tasks.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })
}
//
//#----------------------------------------------------------------------------------------------------------
//
//## suppose you want to attach the policy defined below
//resource "aws_iam_role_policy_attachment" "test-attach" {
//  role       = aws_iam_role.task_role.id
//  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
//  # policy_arn = aws_iam_policy.policy.arn ----> this is when u defined your own policy shown below
//}
//
//#---------------------------------------------------------------------------------------------------------
//# if we wanna create policy and than attach to the above than,
//resource "aws_iam_policy" "policy" {
//  name = "ecs-policy"
//  policy = jsonencode({
//    "Version" : "2012-10-17",
//    "Statement" : [
//      {
//        "Effect" : "Allow",
//        "Action" : [
//          "ecr:GetAuthorizationToken",
//          "ecr:BatchCheckLayerAvailability",
//          "ecr:GetDownloadUrlForLayer",
//          "ecr:BatchGetImage",
//          "logs:CreateLogStream",
//          "logs:PutLogEvents"
//        ],
//        "Resource" : "*"
//      }
//    ]
//  })
//}



