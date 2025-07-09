import 'package:flutter/material.dart';
import 'package:optikick/features/home/presentation/widgets/home_screen_body.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const HomeScreenBody(),
    );
  }
}
