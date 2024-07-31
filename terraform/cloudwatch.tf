resource "aws_cloudwatch_log_group" "sftp_logs" {
  name = "/aws/transfer/sftp"
  retention_in_days = 7
}

resource "aws_cloudwatch_metric_alarm" "missing_upload_alarm" {
  alarm_name          = "MissingUploadAlarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "FailedUploads"
  namespace           = "AWS/Transfer"
  period              = "86400"
  statistic           = "Sum"
  threshold           = "1"

  alarm_actions = [var.sns_topic_arn]
}
