import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:klasmeyt/pages/chat_page.dart';
import 'package:klasmeyt/services/chat_web_service.dart';
import 'package:klasmeyt/themes/colors.dart';
import 'package:klasmeyt/widgets/search_section_button.dart';

class SearchSection extends StatefulWidget {
  const SearchSection({super.key});

  @override
  State<SearchSection> createState() => _SearchSectionState();
}

class _SearchSectionState extends State<SearchSection> {
  final queryController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    queryController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Ano un Klasmeyt?',
          style: GoogleFonts.pixelifySans(
            fontSize: 40,
            fontWeight: FontWeight.w400,
            height: 1.2,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 32),
        Container(
          width: 700,
          decoration: BoxDecoration(
            color: AppColors.searchBar,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: AppColors.searchBarBorder,
              width: 1.5,
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: queryController,
                  decoration: const InputDecoration(
                    hintText: 'Search anything...',
                    hintStyle: TextStyle(
                      color: AppColors.textGrey,
                      fontSize: 16,
                    ),
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    const SearchSectionButton(
                      icon: Icons.auto_awesome_outlined,
                      text: 'Focus',
                    ),
                    const SizedBox(width: 12),
                    const SearchSectionButton(
                      icon: Icons.add_circle_outline_outlined,
                      text: 'Attach',
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        final query = queryController.text.trim();

                        if (query.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                "v0v0 wlang laman ung text field",
                                style: TextStyle(
                                  color: AppColors.whiteColor,
                                  fontSize: 16,
                                ),
                              ),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                          return;
                        }
                        ChatWebService().chat(query);
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ChatPage(question: query),
                          ),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(9),
                        decoration: BoxDecoration(
                          color: AppColors.iconGrey,
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: const Icon(
                          Icons.arrow_forward,
                          color: AppColors.background,
                          size: 16,
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
