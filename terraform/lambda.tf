resource "aws_lambda_function" "upload_checker" {
  filename         = "lambda/upload_checker.zip"
  function_name    = "UploadChecker"
  role             = var.role_arn
  handler          = "index.handler"
  runtime          = "python3.8"
  source_code_hash = filebase64sha256("lambda/upload_checker.zip")
  environment {
    variables = {
      BUCKET_NAME = var.bucket_name
    }
  }
}

resource "aws_lambda_function" "agency_onboarding" {
  filename         = "lambda/agency_onboarding.zip"
  function_name    = "AgencyOnboarding"
  role             = var.role_arn
  handler          = "index.handler"
  runtime          = "python3.8"
  source_code_hash = filebase64sha256("lambda/agency_onboarding.zip")
  environment {
    variables = {
      BUCKET_NAME = var.bucket_name
    }
  }
}

resource "aws_cloudwatch_event_rule" "daily_check" {
  name                = "DailyCheck"
  schedule_expression = "rate(1 day)"
}

resource "aws_cloudwatch_event_target" "lambda_target" {
  rule      = aws_cloudwatch_event_rule.daily_check.name
  target_id = "UploadChecker"
  arn       = aws_lambda_function.upload_checker.arn
}

resource "aws_lambda_permission" "allow_cloudwatch" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.upload_checker.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.daily_check.arn
}

output "upload_checker_arn" {
  value = aws_lambda_function.upload_checker.arn
}

resource "aws_sns_topic" "alerts" {
  name = "sftp-alerts"
}

resource "aws_sns_topic_subscription" "email_subscription" {
  topic_arn = aws_sns_topic.alerts.arn
  protocol  = "email"
  endpoint  = "your-email@example.com"
}

output "sns_topic_arn" {
  value = aws_sns_topic.alerts.arn
}
