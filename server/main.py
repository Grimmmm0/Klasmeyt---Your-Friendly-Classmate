from fastapi import FastAPI
from pydantic_models.chat_body import ChatBody
from services.sort_source_service import SortSourceService
from services.search_service import SearchService

app = FastAPI()
search_service = SearchService()
sort_source_service = SortSourceService()

# Chat POST REQUEST TO GET THE QUERIES OR QUESTIONS FROM THE USERS
@app.post("/chat")
def chat_endpoint(body: ChatBody):
    # Search or Find Relevent Information from the reputable resources
     search_results = search_service.web_search(body.query)
    # Sort the Sources = the most relevant to least query
     sorted_results= sort_source_service.sort_sources(body.query, search_results)
    # Generate the response using the LLM
     print(sorted_results)

     return body.query
