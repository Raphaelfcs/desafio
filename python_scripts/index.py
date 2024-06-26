import json

def handler(event, context):
    message = event.get('status', 'No status provided')
    response = {
        'statusCode': 200,
        'body': json.dumps({'message': message})
    }
    return response
