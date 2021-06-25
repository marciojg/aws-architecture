import json


def gateway(event, context):
    message = event['body'];
    
    response = {
        "statusCode": 200,
        "body": json.dumps(message)
    }

    return response
