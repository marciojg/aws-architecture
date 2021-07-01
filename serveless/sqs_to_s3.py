#import boto3
import json
#import os

def handler(event, context):
    print('recebido handler comoo um objeto')
    print(event)
    
    body = json.dumps(event)
    print(f"body: %s" % body)
    
    response = {
        "statusCode": 200,
        "body": body
    }
    
    return response
    