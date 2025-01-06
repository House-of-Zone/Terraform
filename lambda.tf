# Create out lambda, using a locally sourced zip file

resource "aws_lambda_function" "demo_lambda" {
    function_name = "demo_lambda"
    role = aws_iam_role.demo_lambda_role.arn
    package_type = "Zip"

    #  Specifies the handler function within the Lambda function. For Go-based Lambda functions, this should be the name of the executable.
    handler = "bootstrap"
    runtime = "provided.al2"

    filename = "function.zip"
    source_code_hash = filebase64sha256("function.zip")

    # Ensures that the Lambda function is created only after the specified IAM role (demo_lambda_role) has been created.
    depends_on = [ aws_iam_role.demo_lambda_role
 ]

    tags = {
      Name = "demo_lambda"
    }

  
}

# In order for our cron to work, we need to let our Lambda know that EventBridge is allowed to Invoke it.

resource "aws_lambda_permission" "allow_cloudwatch_to_call_split_lambda" {
    statement_id = "AllowExecutionFromCloudWatch"
    action = "lambda:InvokeFunction"
    function_name = aws_lambda_function.demo_lambda.function_name
    principal = "events.amazonaws.com"
    source_arn = aws_cloudwatch_event_rule.demo_lambda_every_2_minutes.arn
}
