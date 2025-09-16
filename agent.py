from langchain_community.document_loaders import DirectoryLoader
from langchain.text_splitter import RecursiveCharacterTextSplitter
from langchain_community.vectorstores import FAISS
from langchain_community.embeddings import HuggingFaceEmbeddings
from langchain_ollama import OllamaLLM
from langchain.chains import RetrievalQA

# ignore warnings
import warnings
warnings.filterwarnings("ignore")  

# 1. Load docs
loader = DirectoryLoader("./docs", glob="**/*.pdf")  # or *.txt, *.md
docs = loader.load()

# 2. Split docs into chunks
splitter = RecursiveCharacterTextSplitter(chunk_size=1000, chunk_overlap=200)
chunks = splitter.split_documents(docs)

# 3. Embed chunks
embeddings = HuggingFaceEmbeddings(model_name="sentence-transformers/all-MiniLM-L6-v2")
db = FAISS.from_documents(chunks, embeddings)

# 4. Define retriever
retriever = db.as_retriever(search_kwargs={"k": 4})

# 5. Local model via Ollama
llm = OllamaLLM(model="llama3")

# 6. RetrievalQA pipeline
qa = RetrievalQA.from_chain_type(llm=llm, retriever=retriever)

# Example query
while True:
    query = input("Query: ")
    response = qa.run(query)
    print(response)

