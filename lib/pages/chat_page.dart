import 'package:flutter/material.dart';
import 'package:klasmeyt/widgets/answer_section.dart';
import 'package:klasmeyt/widgets/side_bar.dart';
import 'package:klasmeyt/widgets/sources_section.dart';

class ChatPage extends StatelessWidget {
  final String question;
  const ChatPage({super.key, required this.question});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const LeftSideBar(),
          const SizedBox(
            width: 100,
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                Text(
                  question,
                  style: const TextStyle(
                      fontSize: 40, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 24),
                SourcesSection(),
                const SizedBox(height: 24),
                AnswerSection(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
