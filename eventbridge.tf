#Create our schedule
resource "aws_cloudwatch_event_rule" "demo_lambda_every_2_minutes" {
    name = "demo_lambda_every_2_minutes"
    description = "Fires every 2 minutes"
    schedule_expression = "rate(2 minutes)"  
}

# Trigger our lambda every 2 minutes
resource "aws_cloudwatch_event_target" "trigger_lambda_on_schedule" {
    rule = aws_cloudwatch_event_rule.demo_lambda_every_2_minutes.name
    arn = aws_lambda_function.demo_lambda.arn
    target_id = "lambda"
}