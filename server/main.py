from fastapi import FastAPI
from pydantic_models.chat_body import ChatBody
from services.search_service import SearchService

app = FastAPI()
search_service = SearchService()

# Chat POST REQUEST TO GET THE QUERIES OR QUESTIONS FROM THE USERS
@app.post("/chat")
def chat_endpoint(body: ChatBody):
    # Search or Find Relevent Information from the reputable resources
    search_service.web_search()
    # Sort the Sources = the most relevant to least query
    # Generate the response using the LLM
    # Return the response to the user
    return body.query
