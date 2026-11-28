import ollama
from ddgs import DDGS

def web_search(query):
    try:
        results = DDGS().text(query, max_results=5)
        if not results:
            return 'search not found'
        return '\n\n'.join(f"{r['title']}: {r['body']}" for r in results)
    except Exception as e:
        return f'search error: {e}'

def search_and_summarize(query):
    results = web_search(query)
    if results.startswith('search error') or results == 'search not found':
        return 'unable to retrieve the information'
    summary = ollama.chat(
        model='qwen2.5:1.5b',
        messages=[
            {'role':'system','content':'you are an ai assistant and your job is to give the summerize answer from the results'},
            {'role': 'user', 'content': f'Summarize these results:\n{results}'}
        ],
        options={'temperature':0.2,'num_predict':120}
    )
    return summary.message.content

while True:
    query = input('Hello sir, what do you want to search and summarize? (type exit to quit): ').strip()
    if not query:
        continue
    if query.lower() == 'exit':
        print('Thank you for the conversation. Bye!')
        break
    print(search_and_summarize(query))
    print()