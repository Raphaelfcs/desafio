import json

def lambda_handler(event, context):
    message = event.get('status', 'rodou a lamnbda pelo api gtw sucesso')
    response = {
        'statusCode': 200,
        'body': json.dumps({'message': message})
    }
    return response
