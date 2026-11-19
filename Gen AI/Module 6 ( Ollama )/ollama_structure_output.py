import ollama
response=ollama.chat(
    model='llama3.2:1b',
    messages=[
        {
        'role':'user',
         'content':'Abhishek kushwaha is working as Artificial Intelligence Intern In Inevitable Electroninc company'
        }
    ],
    format={
        'type':'object',
        'properties':{
            'name':{'type':'string'},
            'designation':{'type':'string'},
            'company':{'type':'string'}
        },'required':['name','designation','field','company']
    }
)
print(response['message']['content'])

