output "bucket_name" {
  value = module.s3.bucket_name
}

output "transfer_server_id" {
  value = module.transfer.transfer_server_id
}

output "lambda_role_arn" {
  value = module.iam.lambda_role_arn
}

output "upload_checker_arn" {
  value = module.lambda.upload_checker_arn
}

output "sns_topic_arn" {
  value = module.lambda.sns_topic_arn
}
