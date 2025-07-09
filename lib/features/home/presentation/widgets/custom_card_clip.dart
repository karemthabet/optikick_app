import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCardClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    double skewAmount = 10.sp;
    double cornerRadius = 20.r; // Radius for rounded corners

    // Start at top-left (skewed down + rounded)
    path.moveTo(0, skewAmount + cornerRadius);
    path.quadraticBezierTo(0, skewAmount, cornerRadius, skewAmount);

    // Top edge (skewed down)
    path.lineTo(size.width - cornerRadius, 0);
    path.quadraticBezierTo(size.width, 0, size.width, cornerRadius);

    // Right edge
    path.lineTo(size.width, size.height - skewAmount - cornerRadius);
    path.quadraticBezierTo(size.width, size.height - skewAmount,
        size.width - cornerRadius, size.height - skewAmount);

    // Bottom edge (skewed up - mirror of top)
    path.lineTo(cornerRadius, size.height);
    path.quadraticBezierTo(0, size.height, 0, size.height - cornerRadius);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
