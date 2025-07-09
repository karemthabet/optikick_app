import 'package:flutter/material.dart';

class MyClipperPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double radius = 20.0;

    Path path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height * 0.85 - radius)
      ..quadraticBezierTo(size.width, size.height * 0.85, size.width - radius,
          size.height * 0.85)
      ..lineTo(radius, size.height)
      ..quadraticBezierTo(0, size.height, 0, size.height - radius)
      ..lineTo(0, 0)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
