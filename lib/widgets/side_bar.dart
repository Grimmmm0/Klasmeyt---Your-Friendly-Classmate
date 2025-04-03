import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:klasmeyt/themes/colors.dart';
import 'package:klasmeyt/widgets/side_bar_button.dart';

class LeftSideBar extends StatefulWidget {
  const LeftSideBar({super.key});

  @override
  State<LeftSideBar> createState() => _LeftSideBarState();
}

class _LeftSideBarState extends State<LeftSideBar> {
  bool isCollapsed = true;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      width: isCollapsed ? 64 : 150,
      color: AppColors.sideNav,
      child: Column(
        children: [
          const SizedBox(height: 16),
          FaIcon(
            FontAwesomeIcons.ghost,
            color: AppColors.whiteColor,
            size: isCollapsed ? 30 : 60,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: isCollapsed
                  ? CrossAxisAlignment.center
                  : CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                LeftSideBarButton(
                    isCollapsed: isCollapsed, icon: Icons.add, text: "Home"),
                LeftSideBarButton(
                    isCollapsed: isCollapsed,
                    icon: Icons.search,
                    text: "Search"),
                LeftSideBarButton(
                    isCollapsed: isCollapsed,
                    icon: Icons.language,
                    text: "Space"),
                LeftSideBarButton(
                    isCollapsed: isCollapsed,
                    icon: Icons.auto_awesome,
                    text: "Discover"),
                LeftSideBarButton(
                    isCollapsed: isCollapsed,
                    icon: Icons.cloud_outlined,
                    text: "Library"),
                const Spacer(),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                isCollapsed = !isCollapsed;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              margin: const EdgeInsets.symmetric(vertical: 14),
              child: Icon(
                isCollapsed
                    ? Icons.keyboard_arrow_right
                    : Icons.keyboard_arrow_left,
                color: AppColors.iconGrey,
                size: 22,
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
