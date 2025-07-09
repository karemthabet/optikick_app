import 'package:flutter/material.dart';
import 'package:optikick/core/utils/colors.dart';

class SidebarTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final Color iconColor;
  final Color textColor;

  const SidebarTile({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.iconColor = ColorsManager.realWhiteColor,
    this.textColor = ColorsManager.realWhiteColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: iconColor),
      title: Text(
        title,
        style: TextStyle(color: textColor),
      ),
      onTap: () {
        Navigator.pop(context);
        onTap();
      },
    );
  }
}
