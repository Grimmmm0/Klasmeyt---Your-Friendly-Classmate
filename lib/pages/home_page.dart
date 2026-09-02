import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:klasmeyt/feature_box.dart';
import 'package:klasmeyt/openai_service.dart';
import 'package:klasmeyt/themes/colors.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'dart:typed_data';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final speechToText = SpeechToText();
  bool speechEnabled = false;
  bool isGeneratingImage = false;
  String lastWords = '';
  Uint8List? generatedImage;
  String? aiTextAnswer;
  final OpenAIService openAIService = OpenAIService();
  @override
  void initState() {
    super.initState();
    initSpeech();
  }

  void initSpeech() async {
    speechEnabled = await speechToText.initialize(
      onError: (errorNotification) {
        print('=== STT ERROR: ${errorNotification.errorMsg}');
      },
      onStatus: (status) {
        print('=== STT STATUS: $status');
      },
    );
    setState(() {});
  }

  Future<void> startListening() async {
    if (speechEnabled) {
      await speechToText.listen(
        onResult: onSpeechResult,
        listenOptions: SpeechListenOptions(
          localeId: 'en_US', // Use 'tl_PH' for Tagalog recognition
          listenMode: ListenMode.dictation,
          partialResults: true,
          cancelOnError: false,
        ),
      );
      setState(() {});
    }
  }

  Future<void> stopListening() async {
    await speechToText.stop();
    setState(() {});
  }

  void onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      lastWords = result.recognizedWords;
    });
  }

  @override
  void dispose() {
    speechToText.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Klasmeyt'),
        centerTitle: true,
        backgroundColor: AppColors.iconGrey,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Student Avatar
            Stack(
              children: [
                Center(
                  child: Container(
                    height: 115,
                    width: 100,
                    margin: const EdgeInsets.only(top: 4),
                    decoration: const BoxDecoration(
                      color: AppColors.proButton,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Container(
                  height: 123,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('assets/student.png'),
                    ),
                  ),
                )
              ],
            ),
            if (isGeneratingImage)
              const Padding(
                padding: EdgeInsets.all(20),
                child: CircularProgressIndicator(),
              ),
            if (generatedImage != null)
              Container(
                margin: const EdgeInsets.all(20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.memory(generatedImage!),
                ),
              ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              margin:
                  const EdgeInsets.symmetric(horizontal: 40).copyWith(top: 20),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.textGrey),
                borderRadius: BorderRadius.circular(20).copyWith(
                  topLeft: Radius.zero,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  lastWords.isNotEmpty
                      ? lastWords
                      : 'Gandang Araw, Klasmeyt ano yun?',
                  style: const TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: 22,
                  ),
                ),
              ),
            ),
            if (aiTextAnswer != null)
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                margin: const EdgeInsets.symmetric(horizontal: 40)
                    .copyWith(top: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.textGrey),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  aiTextAnswer!,
                  style: const TextStyle(
                      color: AppColors.whiteColor, fontSize: 18),
                ),
              ),

            Visibility(
              visible: aiTextAnswer == null && generatedImage == null,
              child: Container(
                padding: const EdgeInsets.all(10),
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(top: 10, left: 22),
                child: const Text(
                  'Ito ang aking mga tampok',
                  style: TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            // Feature Boxes
            Visibility(
              visible: aiTextAnswer == null && generatedImage == null,
              child: const Column(
                children: [
                  FeatureBox(
                    color: Colors.blueAccent,
                    headerText: 'ChatGPT',
                    descriptionText:
                        'AI para sa lahat: Ang teknolohiyang kahit si lolo, kayang utusan.',
                  ),
                  FeatureBox(
                    color: Colors.greenAccent,
                    headerText: 'HUGGING FACE',
                    descriptionText:
                        'text to image :imahinasyon mo gawin nating realidad',
                  ),
                  FeatureBox(
                    color: Colors.redAccent,
                    headerText: 'Smart Voice Assistant',
                    descriptionText:
                        'Kausap ng bayan: Ang tsismisang may kabuluhan dahil alam lahat ng sagot.',
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        width: 56.0,
        height: 56.0,
        child: FloatingActionButton(
          backgroundColor: AppColors.iconGrey,
          onPressed: () async {
            if (await speechToText.hasPermission &&
                speechToText.isNotListening) {
              await startListening();
            } else if (speechToText.isListening) {
              await stopListening();

              setState(() {
                isGeneratingImage = true;
                aiTextAnswer = null;
                generatedImage = null;
              });

              final routed = await openAIService.routePrompt(lastWords);

              if (routed.trim() == 'GENERATE_IMAGE') {
                final result =
                    await openAIService.huggingFaceImageAPI(lastWords);
                setState(() {
                  isGeneratingImage = false;
                  try {
                    generatedImage = base64Decode(result);
                  } catch (_) {
                    print('IMAGE ERROR: $result');
                  }
                });
              } else {
                setState(() {
                  isGeneratingImage = false;
                  aiTextAnswer = routed;
                });
              }
            } else {
              initSpeech();
            }
          },
          tooltip: 'Listen',
          child: Icon(speechToText.isNotListening ? Icons.mic_off : Icons.mic),
        ),
      ),
    );
  }
}
