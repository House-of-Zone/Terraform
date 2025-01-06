# Store the AWS account_id in a variable so we can refernce it in our IAM policy

data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

locals {
    account_id = data.aws_caller_identity.current.account_id
}

# Lambda IAM Role
resource "aws_iam_role" "demo_lambda_role" {
    name = "demo-lambda-role"
    //Terraform's "jsonencode" function converts a
    # Terraform expression result to valid JSON syntax.
    assume_role_policy = jsonencode({
        Version = "2012-10-17",
        Statement = [
            {
                Effect = "Allow",
                Principal = {
                    Service = "lambda.amazonaws.com"
                },
                Action = "sts:AssumeRole"
            }
        ]
    })

    inline_policy {
        name = "demo-lambda-policies"
        policy = jsonencode({
            Version = "2012-10-17",
            Statement = [
                {
                    Effect = "Allow",
                    Action = [
                        "logs:CreateLogGroup",
                    ],
                    Resource = "arn:aws:logs:${data.aws_region.current.name}:${local.account_id}:*"
                },
                {
                    Effect = "Allow",
                    Action = [
                        "logs:CreateLogStream",
                        "logs:PutLogEvents"
                    ],
                    Resource = "arn:aws:logs:${data.aws_region.current.name}:${local.account_id}:log-group:/aws/lambda/demo_lambda:*"
                }
            ]
        })
    }
    
}