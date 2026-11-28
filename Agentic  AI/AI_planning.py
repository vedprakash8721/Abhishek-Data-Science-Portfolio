import json
import ollama
goal='find the best laptops under 60000 and give me the comparison'
response=ollama.chat(
    model='qwen2.5:1.5b',
    messages=[
        {
            'role':'system',
            'content':' you are an ai assistant and you have to breakdown the user goals and return the task planning in steps and return the task steps in json'
        },
        {
            'role':'user',
            'content':goal
        }
    ],format='json'
)
plan=json.loads(response['message']['content'])
for task in plan['steps']:
    print(task)

"""
output:
venv) inv@inv-V530-15ICR:~/ai_training$ /home/inv/ai_training/venv/bin/python /home/inv/ai_training/Agentic_AI/AI_planning.py
{'action': 'Search online', 'target': 'Laptops', 'description': 'Start by searching for laptops on an online retailer like Amazon, Best Buy, or Walmart.'}
{'action': 'Set budget limit', 'target': '60,000', 'description': 'Ensure the search results are limited to laptops priced under 60,000 dollars.'}
{'action': 'Filter by price', 'target': '60,000', 'description': 'Filter out any results that exceed the 60,000 dollar limit.'}
{'action': 'Select preferred features', 'target': 'Performance, Design, Battery Life', 'description': 'Select criteria that are important to your preferences (e.g., performance, design, battery life).'}
{'action': 'Compare specifications', 'target': '60,000', 'description': 'Compare the specifications of the selected laptops, including their price, performance, design, battery life, and other relevant features.'}
{'action': 'Select the best laptop', 'target': '60,000', 'description': 'Choose the laptop that meets your criteria and is the best fit for your needs.'}
{'action': 'Evaluate options', 'target': '60,000', 'description': 'Evaluate other laptops that may be available and compare them to ensure you are getting the best value for your money.'}
(venv) inv@inv-V530-15ICR:~/ai_training$ 
"""