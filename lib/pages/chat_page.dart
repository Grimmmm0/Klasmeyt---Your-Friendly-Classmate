import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:klasmeyt/pages/home_page.dart';
import 'package:klasmeyt/themes/colors.dart';
import 'package:klasmeyt/widgets/answer_section.dart';
import 'package:klasmeyt/widgets/side_bar.dart';
import 'package:klasmeyt/widgets/sources_section.dart';

class ChatPage extends StatelessWidget {
  final String question;
  const ChatPage({super.key, required this.question});

  bool get isMobile =>
      defaultTargetPlatform == TargetPlatform.android ||
      defaultTargetPlatform == TargetPlatform.iOS;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isMobile ? _buildMobileLayout(context) : _buildWideLayout(context),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              question,
              style: const TextStyle(
                fontSize: 28, // Smaller font for mobile
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const SourcesSection(),
            const SizedBox(height: 24),
            const AnswerSection(),
            const SizedBox(height: 24),
            Center(
              child: IconButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                    (route) => false,
                  );
                },
                icon: const Icon(Icons.refresh_outlined,
                    size: 30, color: AppColors.iconGrey),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWideLayout(BuildContext context) {
    return Row(
      children: [
        const LeftSideBar(),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  question,
                  style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                const SourcesSection(),
                const SizedBox(height: 24),
                const AnswerSection(),
                Center(
                  child: IconButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage()),
                        (route) => false,
                      );
                    },
                    icon: const Icon(Icons.refresh_outlined,
                        size: 30, color: AppColors.iconGrey),
                  ),
                ),
              ],
            ),
          ),
        ),
        const Placeholder(
          fallbackHeight: 100,
          fallbackWidth: 100,
          color: AppColors.background,
        )
      ],
    );
  }
}
