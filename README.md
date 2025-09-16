# Biblioagent: A Local Retrieval-Augmented Generation (RAG) System

`Biblioagent` is a Python-based application that leverages a local Large Language Model (LLM) and a vector database to provide a question-answering system for your personal documents. Simply place your PDF files in the `docs/` directory, and the agent can answer questions based on their content.

This project is built using:
- **LangChain:** For building the RAG pipeline.
- **Hugging Face:** For creating document embeddings.
- **FAISS:** For fast vector search.
- **Ollama:** For running a powerful LLM locally.

---

### Features

- **Document Ingestion:** Automatically loads all PDF files from the `docs/` directory.
- **Text Processing:** Splits documents into manageable chunks for efficient embedding and retrieval.
- **Local Embeddings:** Uses a local sentence-transformer model to create document embeddings.
- **Vector Search:** Utilizes FAISS to build a fast and efficient vector database for similarity search.
- **Local LLM Integration:** Connects to a local Ollama server to use a powerful model like `Llama3` for text generation.

---

### Prerequisites

Before running the installation script, you must have the following tools installed on your system:

1.  **Conda or Mamba:** A package, dependency, and environment manager. If you don't have it, you can follow the official [Conda installation guide](https://docs.conda.io/projects/conda/en/latest/user-guide/install/index.html).
2.  **Ollama CLI:** The command-line tool for running the local LLM server. Follow the official instructions to install it from the [Ollama website](https://ollama.com/download/linux).

---

### Getting Started

Follow these steps to set up the project environment and run the script.

#### 1. Clone the Repository

Clone this repository to your local machine:
```bash
git clone [https://github.com/your-username/biblioagent.git](https://github.com/your-username/biblioagent.git)
cd biblioagent