import 'package:flutter/material.dart';
import 'package:klasmeyt/widgets/side_bar.dart';

class ChatPage extends StatefulWidget {
  final String question;
  const ChatPage({super.key, required this.question});

  @override
  State<ChatPage> createState() => _ChatPageState();
}
//  StreamBuilder(
//               stream: ChatWebService().contentStream,
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return const Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 }
//                 fullResponse += snapshot.data?['data'] ?? '';
//                 return Text(fullResponse);
//               },
//             )

class _ChatPageState extends State<ChatPage> {
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
                  widget.question,
                  style: const TextStyle(
                      fontSize: 40, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 24),
              ],
            ),
          )
        ],
      ),
    );
  }
}
