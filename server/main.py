import asyncio
from fastapi import FastAPI, WebSocket, WebSocketDisconnect
from pydantic_models.chat_body import ChatBody
from services.llm_service import LLMService
from services.sort_source_service import SortSourceService
from services.search_service import SearchService

app = FastAPI()
search_service = SearchService()
sort_source_service = SortSourceService()
llm_service = LLMService()
# Chat POST REQUEST TO GET THE QUERIES OR QUESTIONS FROM THE USERS

# chat websocket
@app.websocket("/ws/chat")
async def websocket_chat_endpoint(websocket: WebSocket):
    await websocket.accept()
    try:
        while True:
            data = await websocket.receive_json()
            query = data.get("query")

            # Step 1: Perform search
            search_results = search_service.web_search(query)
            sorted_results = sort_source_service.sort_sources(query, search_results)

            # Step 2: Send search results
            await websocket.send_json({"type": "search_result", "data": sorted_results})

            # Step 3: Stream LLM response
            for chunk in llm_service.generate_response(query, sorted_results):
                await asyncio.sleep(0.1)  # Simulate delay if needed
                await websocket.send_json({"type": "content", "data": chunk})

    except WebSocketDisconnect:
        print("Client disconnected")
    except Exception as e:
        print(f"Unexpected error occurred: {e}")
    finally:
        await websocket.close()



@app.post("/chat")
def chat_endpoint(body: ChatBody):
    # Search or Find Relevent Information from the reputable resources
     search_results = search_service.web_search(body.query)
     sorted_results = sort_source_service.sort_sources(body.query, search_results)
     response = llm_service.generate_response(body.query, sorted_results)


     return response
