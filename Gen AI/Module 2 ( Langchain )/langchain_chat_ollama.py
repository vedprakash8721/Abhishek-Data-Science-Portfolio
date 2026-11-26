import ollama
from langchain_ollama import ChatOllama
model='qwen2.5:1.5b'
llm=ChatOllama(
    model=model,
    temperature=0
)
response=llm.invoke('what is langgraph?')
print(response.content)