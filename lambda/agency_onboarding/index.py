import json
import boto3
import os

transfer = boto3.client('transfer')
bucket_name = os.environ['BUCKET_NAME']

def handler(event, context):
    # Extract agency information from the event
    agency_name = event['agency_name']
    ssh_public_key = event['ssh_public_key']
    
    # Create a new Transfer Family user
    response = transfer.create_user(
        UserName=agency_name,
        ServerId=os.environ['TRANSFER_SERVER_ID'],
        Role=os.environ['SFTP_ROLE_ARN'],
        HomeDirectory=f'/{bucket_name}/{agency_name}',
        SshPublicKeyBody=ssh_public_key
    )
    
    return {
        'statusCode': 200,
        'body': json.dumps('User created successfully')
    }
