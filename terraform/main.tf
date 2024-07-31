provider "aws" {
  region = "eu-west-1"
}

module "s3" {
  source = "./s3"
}

module "transfer" {
  source = "./transfer"
  bucket_name = module.s3.bucket_name
}

module "iam" {
  source = "./iam"
}

module "lambda" {
  source = "./lambda"
  bucket_name = module.s3.bucket_name
  role_arn = module.iam.lambda_role_arn
}

module "cloudwatch" {
  source = "./cloudwatch"
  lambda_arn = module.lambda.upload_checker_arn
  sns_topic_arn = module.lambda.sns_topic_arn
}
