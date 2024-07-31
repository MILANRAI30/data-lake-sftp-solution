variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}

variable "role_arn" {
  description = "The ARN of the Lambda execution role"
  type        = string
}

variable "sns_topic_arn" {
  description = "The ARN of the SNS topic"
  type        = string
}
