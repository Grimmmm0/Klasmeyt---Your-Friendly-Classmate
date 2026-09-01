# Klasmeyt 🎓

Klasmeyt ("classmate" in Filipino) is a voice-first AI assistant built with Flutter. Speak a question or a request, and Klasmeyt answers back in Tagalog — or generates an image, if that's what you asked for.

There are two versions of this project, built with very different architectures:

- **v1** — Gemini LLM + Python FastAPI backend
- **v2** — Direct API calls from the app, no backend server (this is the version currently under active development)

---

## Version Comparison

| | v1 | v2 (current) |
|---|---|---|
| **LLM** | Gemini | OpenAI (`gpt-3.5-turbo`) |
| **Backend** | Python FastAPI server | None — direct API calls from the Flutter app |
| **Text-to-image** | ❌ Not supported | ✅ Supported (Hugging Face → FLUX.1-schnell via `nscale`) |
| **Request flow** | Flutter app → FastAPI server → Gemini → response | Flutter app → OpenAI / Hugging Face directly |
| **Response type** | Plain prompt-and-answer only | Routes automatically between a text answer or an image, based on user intent |
| **Setup complexity** | Requires running/hosting a separate server | Just API keys — no server to deploy or maintain |

---

## v2 — How It Works

1. **Speech-to-text** — the user's voice is transcribed on-device using `speech_to_text`.
2. **Intent routing** — the transcribed prompt is sent to OpenAI with a system instruction that classifies the request:
   - If it's an image request → returns a `GENERATE_IMAGE` sentinel
   - Otherwise → returns a direct, conversational **Tagalog** answer
3. **Branching**:
   - **Text request** → the OpenAI response is shown directly in the app.
   - **Image request** → the original prompt is sent to Hugging Face's router (`nscale` provider, `black-forest-labs/FLUX.1-schnell` model) to generate the image, which is decoded and displayed inline.

No backend server is required — every call goes straight from the Flutter app to the respective API.

---

## Tech Stack (v2)

- **Flutter** — app framework
- **speech_to_text** — on-device speech recognition
- **OpenAI API** (`gpt-3.5-turbo`) — intent classification + Tagalog text answers
- **Hugging Face Inference Providers** (`nscale` → FLUX.1-schnell) — text-to-image generation

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
const String openAIAPIKEY = 'your_openai_key_here';
const String huggingFaceAPIKEY = 'your_huggingface_key_here';
```

You'll need:
- An **OpenAI API key** — [platform.openai.com](https://platform.openai.com)
- A **Hugging Face access token** — [huggingface.co/settings/tokens](https://huggingface.co/settings/tokens)

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

## Roadmap / Notes

- Hugging Face's Inference Providers occasionally change which provider serves a given model. If image generation starts failing with a `Model not supported by provider` error, check the model's page on Hugging Face for its currently active provider(s) and update the provider name in `openai_service.dart` accordingly.
- v1's FastAPI server code is maintained separately and is not part of this repo.

---

## License

_Add your license here._
