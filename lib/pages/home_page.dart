import 'package:flutter/material.dart';
import 'package:klasmeyt/widgets/side_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Row(
      children: [
        // Start of the left sidebar
        LeftSideBar(),
        // end of the left sidebar
        Column(
          children: [
            // Start Search Section

            // end of the Search Section

            // Start of the Footer Section

            // end of the Footer Section
          ],
        )
      ],
    ));
  }
}
