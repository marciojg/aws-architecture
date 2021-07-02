import boto3
import json
import os
import uuid

# Connect to S3
s3 = boto3.client('s3')

def handler(event, context):
    print('recebido handler como um objeto')
    
    # Cria UUID
    id = uuid.uuid1()
    
    # Captura nome do Bucket
    bucketName=os.environ["BUCKET"]
    
    # Serialize the object
    serializedEvent = json.dumps(event)

    # Name of file
    fileName = '-'.join(event.keys()) + '-' + str(id) + '.txt'
    
    print('serializedEvent', serializedEvent)
    print('id', id)    
    print('fileName', fileName)
    
    # Write to S3
    s3.put_object(Bucket=bucketName, Key=fileName, Body=serializedEvent)
    
    body = fileName + ' ' + 'criado' + 'com body' + ' ' + serializedEvent
    print(body)
    
    response = {
        "statusCode": 200,
        "body": body
    }
    
    return response