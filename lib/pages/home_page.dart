import 'package:flutter/material.dart';
import 'package:klasmeyt/services/chat_web_service.dart';
import 'package:klasmeyt/widgets/search_section.dart';
import 'package:klasmeyt/widgets/side_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    ChatWebService().connect();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(
      children: [
        // Start of the left sidebar
        const LeftSideBar(),
        // end of the left sidebar
        Expanded(
          child: Column(
            children: [
              // Start Search Section
              const Expanded(child: SearchSection()),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        'Developed by Mohad M. Matanog',
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // end of the Search Section

              // Start of the Footer Section

              // end of the Footer Section
            ],
          ),
        )
      ],
    ));
  }
}
