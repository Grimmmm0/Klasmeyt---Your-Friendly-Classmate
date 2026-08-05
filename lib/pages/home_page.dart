import 'package:flutter/material.dart';
import 'package:klasmeyt/classes/message.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Message> _messages = [
    Message(text: "Yow", isUser: true),
    Message(text: "Yow, Ano meron?", isUser: false),
    Message(text: "Ayus lang, ikaw?", isUser: true),
    Message(text: "Angas", isUser: false),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Text("tang ina mo"),
    ));
  }
}
