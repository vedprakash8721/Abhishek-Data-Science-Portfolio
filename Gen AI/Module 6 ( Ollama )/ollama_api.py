# Generate a response
import requests
url='http://localhost:11434/api/generate'
data={
    'model':'qwen2.5:3b',
    'prompt':'what is use of restapi in ollama explain in simple language',
    'stream': False
}
response=requests.post(url,json=data) #requests.post() sends an HTTP POST request. url specifies where to send it.
result=response.json()
print('answer from llm',result['response']) # Converts the API response into a Python dictionary.

