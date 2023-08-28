from opencopilot import OpenCopilot
import os
from typing import List
from langchain.schema import Document
import requests
from langchain.document_loaders import ConfluenceLoader


copilot = OpenCopilot(
    openai_api_key=os.getenv("OPENAI_API_KEY"),
    llm_model_name=os.getenv("LLM_MODEL_NAME"),
    host="0.0.0.0",
    prompt_file=os.getenv("PROMPT_FILE"),
    weaviate_url=os.getenv("WEAVIATE_URL"),
    api_port=3000
    )


@copilot.data_loader
def testLoader() -> List[Document]:
    print("Starting test data load.")
    url = "https://www.example.com/article.html"
    response = requests.get(url)
    return [Document(page_content=response.text, metadata={"source": url})]

@copilot.data_loader
def confluenceDataLoader() -> List[Document]:
    print("Starting confluence scan.", flush=True)
    loader = ConfluenceLoader(
        url="https://ninjacat.atlassian.net/wiki",
        username=os.getenv("CONFLUENCE_USER"), 
        api_key=os.getenv("CONFLUENCE_API_KEY")
    )
    documents = loader.load(space_key="SHIN", include_attachments=False, limit=20)

    # BUG: https://github.com/langchain-ai/langchain/issues/7803
    for doc in documents:
        if 'id' in doc.metadata:
            doc.metadata['docid'] = doc.metadata.pop('id')
    
        
    print("Scanned {} documents from Confluence".format(len(documents)))
    print(documents[0], flush=True)
    return documents

# Run the copilot
copilot()