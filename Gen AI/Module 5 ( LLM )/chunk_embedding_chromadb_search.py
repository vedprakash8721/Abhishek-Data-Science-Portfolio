from sentence_transformers import SentenceTransformer

__import__('pysqlite3')
import sys
sys.modules['sqlite3'] = sys.modules.pop('pysqlite3')
import os
# PostHog/Telemetry error ko Python 3.8 par rokne ke liye
os.environ["ANONYMIZED_TELEMETRY"] = "False"

from sklearn.metrics.pairwise import cosine_similarity
def create_chunk(text,chunk_size=1500,overlap=150):
    start=0
    chunks=[]
    while start<len(text):
        end=start+chunk_size
        chunk=text[start:end]
        chunks.append(chunk)
        start+=chunk_size-overlap
    return chunks
text_path='LLM/text_extraction/agentic_ai_text.txt'
with open(text_path,'r',encoding='utf-8') as f:
    extracted_text=f.read()
chunks=create_chunk(extracted_text,chunk_size=1600,overlap=150)
# print(chunks)
print(f' the length of chunks is {len(chunks)}')
model=SentenceTransformer('sentence-transformers/all-MiniLM-L6-v2')
embeddings=model.encode(chunks)
print(f'texts are converted into vectors and the shape is {embeddings.shape}')
print(f'how our embeddigs look like? {embeddings[0]}')
similarity_matrix=cosine_similarity(embeddings)
print(f'similarity matrix {similarity_matrix.shape}')
print(f'similarity of first vector and second and third is {similarity_matrix[0][:3]}')

#--------------------- creating chroma_db and searching through it ---------------------
import chromadb
print('setting up chroma_db')
client=chromadb.PersistentClient(path='./chroma_db') # creating database
collection=client.get_or_create_collection(name='agentic_ai_collection') #creating collecton like table in sql
chunk_ids=[f'id_{i}' for i in range(len(chunks))]
collection.upsert(
    ids=chunk_ids,
    documents=chunks,
    embeddings=embeddings
)
# database is created and stored
while True:
    user_query=input('enter the question and type exit or quit to end the conversation ')
    print('------------------------------------------------------------------------------------')
    if user_query.lower() in ['exit','quit']:
        print('exiting from the terminal . have a great day ahead')
        break
    if not user_query.strip():
        continue
    query_embedding=model.encode([user_query]).tolist()
    results=collection.query(
        query_embeddings=query_embedding,
        n_results=1
    )
    for text in results['documents'][0]:
        print(text)
        print('--------------------------------')