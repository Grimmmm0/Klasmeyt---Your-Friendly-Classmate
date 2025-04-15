import 'package:flutter/material.dart';
import 'package:klasmeyt/themes/colors.dart';

class SearchSectionButton extends StatefulWidget {
  final IconData icon;
  final String text;
  const SearchSectionButton(
      {super.key, required this.icon, required this.text});

  @override
  State<SearchSectionButton> createState() => _SearchSectionButtonState();
}

class _SearchSectionButtonState extends State<SearchSectionButton> {
  bool isHovered = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) {
        setState(() {
          isHovered = true;
        });
      },
      onExit: (event) {
        setState(() {
          isHovered = false;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: isHovered ? AppColors.proButton : Colors.transparent,
        ),
        child: Row(
          children: [
            Icon(
              widget.icon,
              color: AppColors.iconGrey,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              widget.text,
              style: const TextStyle(
                color: AppColors.textGrey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
