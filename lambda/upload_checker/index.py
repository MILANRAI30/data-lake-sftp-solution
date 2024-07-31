import json
import boto3
import os
from datetime import datetime, timedelta

s3 = boto3.client('s3')
sns = boto3.client('sns')
bucket_name = os.environ['BUCKET_NAME']
sns_topic_arn = os.environ['SNS_TOPIC_ARN']

def handler(event, context):
    now = datetime.utcnow()
    prefix = now.strftime('%Y/%m/%d/')
    response = s3.list_objects_v2(Bucket=bucket_name, Prefix=prefix)
    if 'Contents' not in response:
        message = f"No files uploaded to {bucket_name} on {prefix}"
        sns.publish(TopicArn=sns_topic_arn, Message=message, Subject="Missing Upload Alert")
        return {
            'statusCode': 500,
            'body': json.dumps('No files uploaded')
        }
    return {
        'statusCode': 200,
        'body': json.dumps('Files uploaded successfully')
    }
