import google.generativeai as genai
from config import Settings

settings = Settings()

class LLMService:
    def __init__(self):
        self.model = None
        self.api_key = settings.GEMINI_API_KEY

    def _load_model(self):
        if self.model is None:
            genai.configure(api_key=self.api_key)
            self.model = genai.GenerativeModel("gemini-2.0-flash")

    def generate_response(self, query: str, search_results: list[dict]):
        self._load_model()

        context_text = "\n\n".join([
            f"Source {i+1} ({result['url']}):\n{result['content']}"
            for i, result in enumerate(search_results)
        ])

        full_prompt = f"""
        Ayon sa aking research Klasmeyt, ang tanong mo ay:
        {context_text}

        Query: {query}

        Ang Labo mo Klasmeyt, ayusin mo tanong mo lods, dapat malinaw at maayos.
        """

        response = self.model.generate_content(full_prompt, stream=True)

        for chunk in response:
            yield chunk.text
