import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:optikick/core/widgets/gradient_background.dart';
import 'package:optikick/features/message/presentation/view/widgets/custom_message_app_bar.dart';
import 'package:optikick/features/message/presentation/view/widgets/user_tile_item.dart';

class MessageView extends StatelessWidget {
  const MessageView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> mockMessages = [
      {
        'name': 'Dr. Derek Shepherd',
        'username': 'dshepherd',
        'time': '1h',
        'message': 'Sent you a message',
      },
      {
        'name': 'Dr. Cristina Yang',
        'username': 'cyang',
        'time': '3h',
        'message': 'Appointment notes updated.',
      },
      {
        'name': 'Coach Jürgen Klopp',
        'username': 'klopp',
        'time': '2d',
        'message': 'Tactics shared for next match.',
      },
      {
        'name': 'Physio Mike Riley',
        'username': 'mriley',
        'time': '4d',
        'message': 'Injury report ready.',
      },
      {
        'name': 'Dr. Meredith Grey',
        'username': 'mgrey',
        'time': '5d',
        'message': 'Vitals reviewed, looks good.',
      },
      {
        'name': 'Coach Steven Gerrard',
        'username': 'sgerrard',
        'time': '1w',
        'message': 'Great progress on fitness!',
      },
      {
        'name': 'Mo Salah',
        'username': 'msalah11',
        'time': '2m',
        'message': 'Coach, I’ll be 10 min late today.',
      },
      {
        'name': 'Virgil van Dijk',
        'username': 'virgil4',
        'time': '10m',
        'message': 'Need to reschedule rehab session.',
      },
      {
        'name': 'Luis Díaz',
        'username': 'luisd',
        'time': '30m',
        'message': 'Workout complete 💪',
      },
      {
        'name': 'Darwin Núñez',
        'username': 'nunez9',
        'time': '1h',
        'message': 'Felt great after training!',
      },
      {
        'name': 'Trent Alexander-Arnold',
        'username': 'taa66',
        'time': '3h',
        'message': 'Analysis of last match uploaded.',
      },
      {
        'name': 'Alisson Becker',
        'username': 'ali1',
        'time': '6h',
        'message': 'No issues from physio today.',
      },
      {
        'name': 'Andy Robertson',
        'username': 'robo26',
        'time': '1d',
        'message': 'Discussing next recovery drill.',
      },
      {
        'name': 'Physio Laura Adams',
        'username': 'laura_adams',
        'time': '2d',
        'message': 'Hydration levels logged.',
      },
      {
        'name': 'Analyst Jamie Carragher',
        'username': 'jamie_carra',
        'time': '3d',
        'message': 'Player movement report is ready.',
      },
    ];

    return Scaffold(
      body: GradientBackground(
        child: Column(
          children: [
            SizedBox(height: 0.h),
            CustomMessageAppBar(),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                itemCount: mockMessages.length,
                itemBuilder: (context, index) {
                  final msg = mockMessages[index];
                  return MessageItem(
                    name: msg['name']!,
                    username: msg['username']!,
                    time: msg['time']!,
                    message: msg['message']!,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
