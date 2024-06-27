import json
from desafio.python_scripts.lambda_function import handler

# Simular dados de evento
event = {
    "status": "success"
}

# Simular contexto (pode ser um objeto vazio para testes simples)
context = {}

# Chamar a função handler
response = handler(event, context)

# Exibir a resposta
print(json.dumps(response, indent=4))
