import requests
url='http://localhost:11434/api/chat'
data={
    'model':'qwen2.5:3b',
    'messages':[
        {'role':'system',
         'content':'you are ai assistant'},
         {
             'role':'user',
             'content':'what is rag in simple words'
         }
    ],
    'stream':False
}
response=requests.post(url,json=data)
result=response.json()
print('ai response is: ',result['message']['content'])