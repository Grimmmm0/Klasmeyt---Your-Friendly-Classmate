Klasmeyt - Your Friendly Tropa 🤙

This APK connects to a FastAPI WebSocket + REST API server hosted on Render:
🌐 https://klasmeyt-your-friendly-tropa.onrender.com

⚠️ Important Warning:
Render's free tier has a 512MB memory cap. If the backend becomes unresponsive (especially with large queries or heavy LLM loads), it may be due to memory overflow.
The server may need to be restarted or upgraded to a paid plan.

————————————————————————————————————————————————————

📦 How to Run the Project Locally:

1. Clone the repo and navigate to it:
   git clone <your-repo-url>
   cd <your-project-directory>

2. Install dependencies:
   pip install -r requirements.txt

3. Create a .env file and include:
   GEMINI_API_KEY=your_google_gemini_key
   TAVILY_API_KEY=your_tavily_key

4. Run the backend:
   uvicorn main:app --host 0.0.0.0 --port 10000

5. Update the WebSocket URL in the Flutter app:
   - If running locally on Android Emulator: ws://10.0.2.2:10000/ws/chat
   - If using deployed server: wss://klasmeyt-your-friendly-tropa.onrender.com/ws/chat

————————————————————————————————————————————————————

📌 APK Notes:
- Ensure an internet connection.
- Server should be live on Render to access AI and search features.
- This APK is not in final build version.
