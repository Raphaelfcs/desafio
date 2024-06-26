import boto3
import json

def handler(event, context):
    sns = boto3.client('sns')
    message = {
        'message': 'Hello from the public lambda!',
        'details': event
    }
    response = sns.publish(
        TopicArn=os.environ['SNS_TOPIC_ARN'],  # Utilize variável de ambiente
        Message=json.dumps({'default': json.dumps(message)}),
        MessageStructure='json'
    )
    return {
        'statusCode': 200,
        'body': json.dumps('Message sent to SNS')
    }
