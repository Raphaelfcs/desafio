import boto3
from botocore.auth import SigV4Auth
from botocore.awsrequest import AWSRequest

# Configuração da requisição
method = 'GET'
service = 'execute-api'
host = 'pu0xbd9fle.execute-api.us-east-1.amazonaws.com'
region = 'us-east-1'
endpoint = 'https://{}/prod'.format(host)
canonical_uri = '/prod'

# Criação da requisição
request = AWSRequest(method=method, url=endpoint, headers={'Host': host})

# Criação da assinatura
credentials = boto3.Session().get_credentials()
signer = SigV4Auth(credentials, service, region)
signer.add_auth(request)

# Execução da requisição
response = request.send()

print(response.content)