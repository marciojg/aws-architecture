import boto3
import json
import os

def handler(event, context):
    body = json.loads(event.get('body'))
    print(f"body: %s" % json.dumps(body))
    
    # send to SNS
    sns = boto3.client('sns')
    snsArn=os.environ["snsArn"]

    res = sns.publish(
                    TopicArn=snsArn,
                    Subject="Sell Book",
                    Message=json.dumps(body),
                    )
    
    response = {
            "isBase64Encoded": False,
            "headers": {
                "Content-Type": "application/json"
            },
            "statusCode": 200,
            "body": json.dumps(body)
        }

    return response
