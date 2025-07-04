from typing import List
from sentence_transformers import SentenceTransformer
import numpy as np

class SortSourceService:
    def __init__(self):
        self.embedding_model = None

    def _load_model(self):
        if self.embedding_model is None:
            self.embedding_model = SentenceTransformer("all-miniLM-L6-v2")

    def sort_sources(self, query: str, search_results: List[dict]):
        try:
            self._load_model()

            query_embedding = self.embedding_model.encode(query)
            relevant_docs = []

            for res in search_results:
                res_embedding = self.embedding_model.encode(res["content"])
                similarity = float(
                    np.dot(query_embedding, res_embedding) /
                    (np.linalg.norm(query_embedding) * np.linalg.norm(res_embedding))
                )

                res["relevance_score"] = similarity
                if similarity > 0.4:
                    relevant_docs.append(res)

            return sorted(relevant_docs, key=lambda x: x["relevance_score"], reverse=True)

        except Exception as e:
            print(f"[SortSourceService ERROR] {e}")
            return []
