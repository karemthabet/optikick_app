import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationTile extends StatelessWidget {
  final IconData leadingIcon;
  final String title;
  final String subtitle;
  final String handle;
  final bool isNotRead;
  final Function? onTap;

  const NotificationTile({
    super.key,
    required this.leadingIcon,
    required this.title,
    required this.subtitle,
    required this.handle,
    this.isNotRead = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap != null ? () => onTap!() : null,
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
      leading: Icon(
        leadingIcon,
        size: 36.sp,
        color: Colors.white,
      ),
      trailing: Visibility(
        visible: isNotRead,
        child: CircleAvatar(
          radius: 5.sp,
          backgroundColor: Colors.red,
        ),
      ),
      title: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
                color: Colors.white,
              ),
            ),
            if (handle.isNotEmpty)
              TextSpan(
                text: ' $handle',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14.sp,
                ),
              ),
          ],
        ),
      ),
      subtitle: Padding(
        padding: EdgeInsets.only(top: 2.h),
        child: Text(
          subtitle,
          style: TextStyle(
            color: Colors.white70,
            fontSize: 13.sp,
          ),
        ),
      ),
    );
  }
}
