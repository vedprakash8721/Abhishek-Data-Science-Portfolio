import pymupdf
pdf_path='LLM/text_extraction/LLM.pdf'
text_path='LLM/text_extraction/llm_text.txt'
doc=pymupdf.open(pdf_path) #Opens the PDF file and loads it into memory as a Document object (doc)
with open(text_path,'w',encoding='utf-8') as f:
    for page_num,page in enumerate(doc,start=1):
        text=page.get_text('text')
        f.write(f'-------{page_num}--------')
        f.write(text)
doc.close() #Closes the PDF file and frees up any system resources or file handles associated with it.
print(f'pdf to text extraction is complete and file saved at  {text_path}')