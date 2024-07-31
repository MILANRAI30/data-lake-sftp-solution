# Data Lake SFTP Solution

This project provides an automated and secure solution for agencies to upload files to an S3 bucket using SFTP. The solution is deployed in AWS using Terraform and includes monitoring and alerting.

## Components

- **AWS Transfer Family**: Provides SFTP access.
- **Amazon S3**: Stores uploaded files.
- **AWS Lambda**: Automates upload checking and agency onboarding.
- **Amazon CloudWatch**: Monitors and alerts on missing uploads.
- **AWS IAM**: Manages access control.

## Setup

1. Clone the repository.
2. Navigate to the `terraform` directory.
3. Update the variables in `variables.tf`.
4. Deploy the infrastructure using Terraform:

    ```bash
    terraform init
    terraform apply
    ```

## Lambda Functions

- **Upload Checker**: Checks for missing uploads and sends alerts.
- **Agency Onboarding**: Onboards new agencies by creating SFTP users.

## Monitoring and Alerting

- **CloudWatch Logs**: Stores logs for SFTP uploads.
- **CloudWatch Alarms**: Sends alerts for missing uploads.
- **SNS Topic**: Sends email notifications for alerts.

## Security

- **IAM Roles and Policies**: Follow the principle of least privilege.
- **S3 Bucket Policies**: Restrict access to the bucket.

## Cost Optimization

- Utilizes AWS Free Tier services.
- Scheduled Lambda functions run once a day.
- Log retention policies to limit storage costs.

## Rollback

To clean up all resources, run:

```bash
terraform destroy
