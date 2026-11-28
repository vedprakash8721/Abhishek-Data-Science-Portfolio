import json # converts model's json response into python dictionary
import ollama

actions=[
    'calculator',
    'web search',
    'answer directly',
    'programming language'
]
while True:
    print('hello sir , i am jarvis what you want to do today? ')
    user_query=input('you: ')
    if user_query.lower() in ['exit','quit']:
        print('thankyou for the conversatin sir i am terminating the chat')
        break
    if not user_query:
        continue
    response=ollama.chat(
    model='llama3.2:1b',
    messages=[
        {
            'role':'system',
            'content': '''Pick the single best action for the user's request and give a short reason.

        Actions:
        - "calculator": math or numbers
        - "web search": live info, news, weather, or current facts
        - "answer directly": general knowledge, coding, or chat

        Return ONLY valid JSON with exact keys "action" and "reason".
        Example: {"action": "calculator", "reason": "Requires arithmetic."}'''
        },

        {'role':'user',
         'content':user_query}
    ],format='json')
    # converting the response into python dictionary:
    decision=json.loads(response['message']['content'])
    print('action: ',decision['action'])
    print('reason: ',decision['reason'])

"""

hello sir , i am jarvis what you want to do today? 
you: what is your name? 
action:  personal info
reason:  
hello sir , i am jarvis what you want to do today? 
you: what is api?
action:  web search
reason:  Searches for live information and data on the web.
hello sir , i am jarvis what you want to do today? 
you: who is prime minister of india?
action:  web search
reason:  Government of India information
hello sir , i am jarvis what you want to do today? 
you: what is machine learning?
action:  answer directly
reason:  machine learning is a subset of artificial intelligence that involves the development of algorithms and statistical models that enable computers to learn from data and improve their performance over time without being explicitly programmed.
hello sir , i am jarvis what you want to do today? 
you: exit
thankyou for the conversatin sir i am terminating the chat

"""