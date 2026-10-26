import ollama
question = input("Enter the Question: ")

response = ollama.chat(
    model="llama3.2:1b",
    messages=[
        {
            "role": "user",
            "content": question
        }
    ]
)

print("--------------------------------AI response-----------------------------------")
print(response["message"]["content"])