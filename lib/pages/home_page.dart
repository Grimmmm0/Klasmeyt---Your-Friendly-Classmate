import 'package:flutter/material.dart';
import 'package:klasmeyt/feature_box.dart';
import 'package:klasmeyt/themes/colors.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Fixed: Removed duplicate @override decorator here
  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize(
      onError: (errorNotification) {
        print(
            '=== STT ERROR: ${errorNotification.errorMsg} - Permanent: ${errorNotification.permanent}');
      },
      onStatus: (status) {
        print('=== STT STATUS: $status');
      },
    );
    print('=== STT INITIALIZED: $_speechEnabled');
    setState(() {});
  }

  void _startListening() async {
    if (_speechEnabled) {
      await _speechToText.listen(
        onResult: _onSpeechResult,
        localeId: 'en_US', // Change to 'tl_PH' if you want Tagalog recognition
      );
      setState(() {});
    }
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Klasmeyt'),
        centerTitle: true,
        leading: const Icon(Icons.menu_outlined),
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

            // Speech Bubble / Output Box
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
                  // Displays spoken words if available, otherwise shows greeting
                  _lastWords.isNotEmpty
                      ? _lastWords
                      : 'Gandang Araw, Klasmeyt ano yun?',
                  style: const TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: 22,
                  ),
                ),
              ),
            ),

            // Section Title
            Container(
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

            // Feature Boxes
            const Column(
              children: [
                FeatureBox(
                  color: Colors.blueAccent,
                  headerText: 'ChatGPT',
                  descriptionText:
                      'AI para sa lahat: Ang teknolohiyang kahit si lolo, kayang utusan.',
                ),
                FeatureBox(
                  color: Colors.greenAccent,
                  headerText: 'Dall-E',
                  descriptionText:
                      'DALL-E ng nakakarami: Kahit lola mo, kayang maging instant pintor.',
                ),
                FeatureBox(
                  color: Colors.redAccent,
                  headerText: 'Smart Voice Assistant',
                  descriptionText:
                      'Kausap ng bayan: Ang tsismisang may kabuluhan dahil alam lahat ng sagot.',
                )
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        width: 56.0, // Increased to default FAB size so icon isn't clipped
        height: 56.0,
        child: FloatingActionButton(
          backgroundColor: AppColors.iconGrey,
          onPressed:
              _speechToText.isNotListening ? _startListening : _stopListening,
          tooltip: 'Listen',
          child: Icon(_speechToText.isNotListening ? Icons.mic_off : Icons.mic),
        ),
      ),
    );
  }
}
