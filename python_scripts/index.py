import json

def handler(event, context):
    if event.get('status') == 'success':
        message = 'Success: Lambda executed successfully!'
    else:
        message = 'Failure: Lambda execution failed!'

    return {
        'statusCode': 200,
        'body': json.dumps({'message': message})
    }
