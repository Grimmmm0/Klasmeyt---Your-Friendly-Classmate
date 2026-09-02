import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:klasmeyt/secrets.dart';

class OpenAIService {
  Future<String> routePrompt(String prompt) async {
    try {
      final res = await http.post(
        Uri.parse('https://router.huggingface.co/nscale/v1/chat/completions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $huggingFaceAPIKEY',
        },
        body: jsonEncode({
          "model": "meta-llama/Llama-3.1-8B-Instruct",
          "messages": [
            {
              "role": "system",
              "content": "You are a routing assistant for a Filipino voice app called Klasmeyt. "
                  "If the user is asking you to draw, generate, create, or show an image/picture, respond with "
                  "exactly this token and nothing else: GENERATE_IMAGE. "
                  "Otherwise, answer their question or respond to their message directly, briefly, and "
                  "conversationally (1-3 sentences), always in casual/conversational Tagalog, "
                  "regardless of what language the user asked in.",
            },
            {'role': 'user', 'content': prompt},
          ],
        }),
      );

      print("ROUTE STATUS: ${res.statusCode}");

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        final reply =
            (data['choices'][0]['message']['content'] as String).trim();
        print("ROUTE REPLY: $reply");
        return reply;
      }

      print("ROUTE ERROR: ${res.body}");
      return "Error: ${res.statusCode} - ${res.body}";
    } catch (e) {
      print("ROUTE EXCEPTION: $e");
      return "Error: $e";
    }
  }

  Future<String> huggingFaceImageAPI(String prompt) async {
    try {
      final res = await http.post(
        Uri.parse('https://router.huggingface.co/nscale/v1/images/generations'),
        headers: {
          'Authorization': 'Bearer $huggingFaceAPIKEY',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "model": "black-forest-labs/FLUX.1-schnell",
          "prompt": prompt,
          "response_format": "b64_json",
          "num_inference_steps": 5,
        }),
      );

      print("HF STATUS: ${res.statusCode}");

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        final imageBase64 = data['data'][0]['b64_json'] as String;
        print("IMAGE GENERATED SUCCESSFULLY");
        print("IMAGE BASE64 LENGTH: ${imageBase64.length}");
        return imageBase64;
      }

      print("HF ERROR: ${res.body}");
      return "HF Error: ${res.statusCode} - ${res.body}";
    } catch (e) {
      print("HF EXCEPTION: $e");
      return "HF Error: $e";
    }
  }

  Future<String> chatGPTAI(String prompt) async {
    return 'CHATGPT';
  }

  Future<String> dallEAPI(String prompt) async {
    return 'DALL-E';
  }
}
