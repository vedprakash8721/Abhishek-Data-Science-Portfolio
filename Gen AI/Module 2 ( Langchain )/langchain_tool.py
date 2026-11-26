
from langchain_ollama import ChatOllama
from langchain.tools import tool

MODEL = "qwen2.5:3b"

@tool
def calculator(a: float, b: float, operation: str) -> float:
    """Perform addition, subtraction, multiplication or division."""

    if operation == "add":
        return a + b

    elif operation == "sub":
        return a - b

    elif operation == "mul":
        return a * b

    elif operation == "div":
        if b == 0:
            return "Cannot divide by zero"
        return a / b

    return "Invalid operation"


llm = ChatOllama(
    model=MODEL,
    temperature=0
)

llm_with_tools = llm.bind_tools([calculator])

response = llm_with_tools.invoke(
    "add 87 and 89"
)

print(response.tool_calls)