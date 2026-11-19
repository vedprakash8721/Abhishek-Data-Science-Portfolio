import ollama
def calculator(a,b):
    return a*b

tools=[
    {
        'type':'function',
        'function':{
            'name':'calculator',
            'description':'multiply the numbers',
            'parameters':{
                'type':'object',
                'properties':{
                    'a':{'type':'number'},
                    'b':{'type':'number'}
                },
                'required':['a','b']
            }
        }
    }
]
messages=[
        {
            'role':'user',
            'content':'what 58 multiple by 79'
        }
    ]

response=ollama.chat(
    model='qwen2.5:3b',
    messages=messages,
    tools=tools
)
# get the tool call
tool_call=response['message']['tool_calls'][0]
#get the arguments:
args=tool_call['function']['arguments']
#execute the calculator:
result=calculator(args['a'],args['b'])
messages.append(response['message'])
messages.append(
    {
        'role':'tool',
        'tool_name':'calculator',
        'content':str(result)
    }
)

# get the final answer:
final_answer=ollama.chat(
    model='qwen2.5:3b',
    messages=messages
)
print('AI Response is :',final_answer['message']['content'])