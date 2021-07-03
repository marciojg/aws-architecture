import boto3
import json
import os
import uuid

# Connect to S3
s3 = boto3.client('s3')

def handler(event, context):
    print('recebido handler como um objeto', event)
    
    # Cria UUID
    id = uuid.uuid1()
    
    # Captura nome do Bucket
    bucketName=os.environ["BUCKET"]
    
    # String object capturated of event
    eventBody = event.get('Records')[0].get('body')
    
    # Body as object
    eventBodyObj = json.loads(eventBody) 
    
    # Name of file
    fileName = '-'.join(eventBodyObj.keys()) + '-' + str(id) + '.txt'
    
    print('eventBody', eventBody)
    print('id', id)    
    print('fileName', fileName)
    
    # Write to S3
    s3.put_object(Bucket=bucketName, Key=fileName, Body=eventBody)
    
    # Print log
    log = ['objeto com nome', fileName, 'criado com body', eventBody]
    body = ' '.join(log)
    
    print('corpo do arquivo criado', body)
    
    response = {
        "statusCode": 200,
        "body": body
    }
    
    return response