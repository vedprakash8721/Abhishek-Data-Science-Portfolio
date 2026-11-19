# extracting the text from the pdf--------------------------------------------------------------------------------------
import pymupdf
pdf_path='RAG_PDF_CHAT/PDFs/AGENTIC AI.pdf'
doc=pymupdf.open(pdf_path)
pages=[]
for page_num,page in enumerate(doc,start=1):
    text=page.get_text('text')
    if text.strip():
        pages.append(
            {
                'page_number':page_num,
                'text': text
            }
        )
doc.close()
print(f'total pages extracted from the pdf {len(pages)}')
print(pages[0])

# creating chunks with page num-----------------------------------------------------------------------------------
def create_chunk(pages,chunk_size=1500,overlap=200):
    chunks=[]
    for page in pages:
        text=page['text']
        page_num=page['page_number']
        start=0
        while start<len(text):
            end=start+chunk_size
            text_chunk=text[start:end]
            chunks.append({
                'page_number':page_num,
                'text':text_chunk
            })
            start+=chunk_size-overlap
    return chunks
chunks=create_chunk(pages)
print(f'total chunks created: {len(chunks)}')
print(chunks[0])

# converting into vectors ( embeddings )---------------------------------------------------------------------------------

from sentence_transformers import SentenceTransformer
model=SentenceTransformer('sentence-transformers/all-MiniLM-L6-v2')
chunk_texts=[chunk['text']for chunk in chunks]
embeddings=model.encode(chunk_texts)
print(f'length of generated embeddings: {len(embeddings)}')
print(f'shape of the embeddings: {embeddings.shape}')

# store chunks and embeddings in chroma_db-------------------------------------------------------------------------------

__import__('pysqlite3')
import sys
sys.modules['sqlite3'] = sys.modules.pop('pysqlite3')
import chromadb
client=chromadb.PersistentClient(path='RAG_PDF_CHAT/chroma_db')
collection=client.get_or_create_collection(name='agentic_ai_collection')
chunk_ids=[f'chunk_{i}' for i in range(len(chunks))]
collection.upsert(
    ids=chunk_ids,
    documents=chunk_texts,
    embeddings=embeddings,
    metadatas=[
        {'page_number':chunk['page_number']} for chunk in chunks
    ]
)
print('chunks are stored in chroma_db')
print(f'the number of chunk stored in chroma_db is { collection.count()}')

#user query and retrieving part -------------------------------------------------------------------------------------------
import ollama
while True:
    user_query=input('\n Enter the Question to search and for terminating the conversation type exit or quit ')
    if user_query.lower() in ['exit','quit']:
        print('terminating the conversation have a great day buddy , see you again ')
        break
    query_embedding=model.encode([user_query]).tolist()
    results=collection.query(
        query_embeddings=query_embedding,
        n_results=3
    )
    context = ""
    for i, document in enumerate(results['documents'][0]):
        page_number = results['metadatas'][0][i]['page_number']
        context += f"\n[Page {page_number}]\n{document}\n"

    # Send context and question to Ollama
    response = ollama.chat(
        model='llama3.2:3b',
        messages=[
            {
                'role': 'system',

                'content': f"""
                You are PagePilot, an accurate PDF question-answering assistant.

                IMPORTANT RULES:

                1. Answer strictly using the provided PDF context.
                2. Your response language must be in english language.
                3. If English is selected, answer completely in English.
                4. If Hindi is selected, answer completely in Hindi.
                5. Never mix languages unless necessary for technical terms.
                6. Do not use your general knowledge to add information
                that is not present in the PDF.
                7. Do not invent facts, examples, statistics or explanations.
                8. If the PDF does not contain sufficient information,
                clearly say that the answer cannot be found in the document.
                9. Mention the relevant PDF page numbers.
                10. Keep answers clear and relevant to the question.
                """
            },
            {
                'role': 'user',
                'content': f"PDF Context:\n{context}\nQuestion: {user_query}"
            }
        ]
    )

    print("\nAnswer:")
    print(response['message']['content'])