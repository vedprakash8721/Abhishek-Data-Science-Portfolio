from ddgs import DDGS
import operator
from datetime import datetime
import ollama

# creating function:
# --------------------------------------- Date & Time ----------------------------------------
def get_datetime():
    return datetime.now().strftime("%d-%m-%Y %H:%M:%S")

# ----------------------------------------- Calculator ------------------------------------------
def calculator(a, b, operation):
    operations = {
        'add': operator.add,
        'sub': operator.sub,
        'mul': operator.mul,
        'div': operator.truediv
    }
    if operation not in operations:
        return 'unsupported operation'
    if operation == 'div' and b == 0:
        return 'error: can not divide by zero'
    return operations[operation](a, b)

# ------------------------------------------ Web Search ---------------------------------------
def web_search(query):
    try:
        results = DDGS().text(query, max_results=3)
        if not results:
            return 'search not found'

        formatted_result = []
        for result in results:
            formatted_result.append(
                f"Title: {result.get('title')}\n"
                f"URL: {result.get('href')}\n"
                f"Snippet: {result.get('body')}"
            )
        return "\n\n".join(formatted_result)

    except Exception as e:
        return f'search error {str(e)}'

# ----------------------------------Define tool schemas-----------------------------------------
tools = [
    {
        'type': 'function',
        'function': {
            'name': 'calculator',
            'description': 'perform mathematical calculation based on input',
            'parameters': {
                'type': 'object',
                'properties': {
                    'a': {'type': 'number'},
                    'b': {'type': 'number'},
                    'operation': {
                        'type': 'string',
                        'enum': ['add', 'sub', 'mul', 'div']
                    }
                },
                'required': ['a', 'b', 'operation']
            }
        }
    },
    {
        "type": "function",
        "function": {
            "name": "get_datetime",
            "description": "Get the current date and time",
            "parameters": {
                "type": "object",
                "properties": {},
                "required": []
            }
        }
    },
    {
        "type": "function",
        "function": {
            "name": "web_search",
            "description": (
                "Search the internet for current information, "
                "recent events, latest news, or specific information "
                "that needs web research."
            ),
            "parameters": {
                "type": "object",
                "properties": {
                    "query": {
                        "type": "string",
                        "description": "The topic or question to search for"
                    }
                },
                "required": ["query"]
            }
        }
    }
]

messages = [
    {
        "role": "system",
        "content": """
        You are a helpful AI assistant.

        Follow these rules:
        1. For current date or time questions, use get_datetime.
        2. For latest news, recent events, or information requiring
           web research, use web_search.
        3. For general knowledge, explanations, and normal questions,
           answer directly without using tools.
        4. For mathematical calculations, use calculator.
        5. When search results are provided, use them to answer
           and do not invent unsupported facts.
        """
    }
]

MODEL = "qwen2.5:3b"

# Connect tool names with Python functions
available_tools = {
    "get_datetime": get_datetime,
    "web_search": web_search,
    "calculator": calculator
}

while True:
    user_query = input('hello sir, i am jarvis how can i help you sir ? ')

    if user_query.lower() in ['exit', 'quit']:
        print('thankyou for the chat sir, have a great day ahead:')
        break

    if not user_query.strip():
        continue

    messages.append({
        "role": "user",
        "content": user_query
    })

    # Ask the LLM
    response = ollama.chat(
        model=MODEL,
        messages=messages,
        tools=tools
    )

    # Check whether LLM requested a tool
    tool_calls = response.message.tool_calls or []

    if not tool_calls:
        print("Assistant:", response.message.content)
        messages.append(response.message)

    else:
        # Save LLM's tool request
        messages.append(response.message)

        # Execute the requested tool
        for tool_call in tool_calls:
            name = tool_call.function.name
            args = tool_call.function.arguments

            print("Using tool:", name)

            result = available_tools[name](**args)

            # Send result back to LLM
            messages.append({
                "role": "tool",
                "tool_name": name,
                "content": str(result)
            })

        # Ask LLM to generate final answer
        final_response = ollama.chat(
            model=MODEL,
            messages=messages
        )

        print("Assistant:", final_response.message.content)
        messages.append(final_response.message) 