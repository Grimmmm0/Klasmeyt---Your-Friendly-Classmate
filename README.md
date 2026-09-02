# Klasmeyt 🎓

Klasmeyt ("classmate" in Filipino) is a voice-first AI assistant built with Flutter. Speak a question or a request, and Klasmeyt answers back in Tagalog — or generates an image, if that's what you asked for.

There are two versions of this project, built with very different architectures:

- **v1** — Gemini LLM + Python FastAPI backend
- **v2** — Direct API calls from the app, no backend server (this is the version currently under active development)

---

## Version Comparison

| | v1 | v2 (current) |
|---|---|---|
| **LLM** | Gemini | Hugging Face (`meta-llama/Llama-3.1-8B-Instruct` via `nscale`) |
| **Backend** | Python FastAPI server | None — direct API calls from the Flutter app |
| **Text-to-image** | ❌ Not supported | ✅ Supported (Hugging Face → FLUX.1-schnell via `nscale`) |
| **Request flow** | Flutter app → FastAPI server → Gemini → response | Flutter app → Hugging Face directly |
| **Response type** | Plain prompt-and-answer only | Routes automatically between a text answer or an image, based on user intent |
| **Setup complexity** | Requires running/hosting a separate server + `.env` config | Just one API key — no server to deploy or maintain |

---

## v2 — How It Works

1. **Speech-to-text** — the user's voice is transcribed on-device using `speech_to_text`.
2. **Intent routing** — the transcribed prompt is sent to Hugging Face's router (`nscale` provider, `meta-llama/Llama-3.1-8B-Instruct` model) with a system instruction that classifies the request:
   - If it's an image request → returns a `GENERATE_IMAGE` sentinel
   - Otherwise → returns a direct, conversational **Tagalog** answer
3. **Branching**:
   - **Text request** → the model's response is shown directly in the app.
   - **Image request** → the original prompt is sent to Hugging Face's router again, this time to the `nscale` provider's `black-forest-labs/FLUX.1-schnell` model, to generate the image, which is decoded and displayed inline.

No backend server is required, and no OpenAI key is needed — every call goes straight from the Flutter app to Hugging Face.

---

## Tech Stack (v2)

- **Flutter** — app framework
- **speech_to_text** — on-device speech recognition
- **Hugging Face Inference Providers** (`nscale`):
  - `meta-llama/Llama-3.1-8B-Instruct` — intent classification + Tagalog text answers
  - `black-forest-labs/FLUX.1-schnell` — text-to-image generation

---

## Setup

### 1. Clone the repo
```bash
git clone <your-repo-url>
cd klasmeyt
flutter pub get
```

### 2. Add your API keys

This project keeps API keys out of version control. Create `lib/secrets.dart` (already listed in `.gitignore`, so it will never be committed):

```dart
const String huggingFaceAPIKEY = 'your_huggingface_key_here';
```

You'll need:
- A **Hugging Face access token** — [huggingface.co/settings/tokens](https://huggingface.co/settings/tokens)

That's the only key v2 needs — no OpenAI account required.

> ⚠️ Never commit `secrets.dart`. If a key is ever accidentally pushed, rotate it immediately at the provider's dashboard, even on a private repo.

### 3. Run the app
```bash
flutter run
```

---

## Permissions

The app requires microphone access for speech recognition. On Android 12+, also ensure `BLUETOOTH_CONNECT` is declared if testing with Bluetooth headsets:

```xml
<uses-permission android:name="android.permission.RECORD_AUDIO" />
<uses-permission android:name="android.permission.BLUETOOTH_CONNECT" />
```

---

## A Note on v1

v1's FastAPI server code is maintained separately and is not part of this repo. If you're setting up or running v1, remember it needs its **own `.env` file** for the Gemini API key (and any other server-side config) — this is completely separate from v2's `lib/secrets.dart`.

```
# .env (v1 backend, not this repo)
GEMINI_API_KEY=your_gemini_key_here
```

Make sure that `.env` is gitignored on the v1 side too, and that the key is rotated if it's ever accidentally committed — same rule as `secrets.dart` here.

## Roadmap / Notes

- Hugging Face's Inference Providers occasionally change which provider serves a given model. If image generation or text routing starts failing with a `Model not supported by provider` error, check the model's page on Hugging Face for its currently active provider(s) and update the provider/model name in `openai_service.dart` accordingly.

---

## License

_Add your license here._
