import 'package:flutter/material.dart';
import 'package:klasmeyt/themes/colors.dart';

class LeftSideBarButton extends StatelessWidget {
  final bool isCollapsed;
  final IconData icon;
  final String text;
  const LeftSideBarButton({
    super.key,
    required this.isCollapsed,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          isCollapsed ? MainAxisAlignment.center : MainAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
          child: Icon(
            icon,
            color: AppColors.iconGrey,
            size: 22,
          ),
        ),
        isCollapsed
            ? const SizedBox()
            : Text(
                text,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              )
      ],
    );
  }
}
