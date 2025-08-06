retrieve_rag_diff_ways_bedrock_faiss

Sure! Below are **two complete code snippets** for setting up RAG using a **FAISS vector store** with **AWS Bedrock as the LLM**, in both approaches:

---

### ✅ **1. Manual FAISS Retrieval (Lower-level)**

```python
from langchain_community.vectorstores import FAISS
from langchain_community.embeddings import BedrockEmbeddings
from langchain.llms.bedrock import Bedrock
from langchain_core.prompts import PromptTemplate
from langchain_core.runnables import RunnableLambda, RunnableMap, RunnablePassthrough
from langchain_core.output_parsers import StrOutputParser

# Embedding and FAISS setup
embedding_model = BedrockEmbeddings(model_id="amazon.titan-embed-text-v1")  # Or use another embedding
vector_store = FAISS.load_local("faiss_index", embeddings=embedding_model)

# Manual retriever logic
def retrieve_docs(question):
    return vector_store.similarity_search(question, k=5)

# Prompt
prompt = PromptTemplate.from_template(
    "Answer the question using the context:\n\nContext:\n{context}\n\nQuestion: {question}"
)

# Bedrock LLM setup
llm = Bedrock(model_id="anthropic.claude-v2", region_name="us-east-1")

# Chain using manual retrieval
rag_chain = (
    RunnableMap({
        "context": RunnableLambda(lambda x: "\n\n".join([doc.page_content for doc in retrieve_docs(x["question"])])),
        "question": RunnablePassthrough()
    })
    | prompt
    | llm
    | StrOutputParser()
)

# Use chain
response = rag_chain.invoke({"question": "What is AWS Bedrock?"})
print(response)
```

---

### ✅ **2. High-level API (`as_retriever()` Method)**

```python
from langchain_community.vectorstores import FAISS
from langchain_community.embeddings import BedrockEmbeddings
from langchain.llms.bedrock import Bedrock
from langchain_core.prompts import PromptTemplate
from langchain_core.runnables import RunnablePassthrough
from langchain_core.output_parsers import StrOutputParser

# Embedding and FAISS setup
embedding_model = BedrockEmbeddings(model_id="amazon.titan-embed-text-v1")
vector_store = FAISS.load_local("faiss_index", embeddings=embedding_model)

# High-level retriever
retriever = vector_store.as_retriever(
    search_type="similarity",
    search_kwargs={"k": 5}
)

# Prompt
rag_prompt = PromptTemplate.from_template(
    "Answer the question using the context:\n\nContext:\n{context}\n\nQuestion: {question}"
)

# Bedrock LLM
llm = Bedrock(model_id="anthropic.claude-v2", region_name="us-east-1")

# Chain using retriever
rag_chain = (
    {"context": retriever, "question": RunnablePassthrough()}
    | rag_prompt
    | llm
    | StrOutputParser()
)

# Use chain
response = rag_chain.invoke({"question": "What is AWS Bedrock?"})
print(response)
```

---

Both approaches will work the same way in terms of final output. Use:

* **Approach 1** for more control (e.g., filtering results, customizing ranking).
* **Approach 2** for cleaner, faster development with reusable components.

Would you like a diagram of how this chain flows visually?
