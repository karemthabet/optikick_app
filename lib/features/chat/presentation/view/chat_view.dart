import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:optikick/core/widgets/gradient_background.dart';

// ignore: must_be_immutable
class ChatView extends StatelessWidget {
  ChatView({super.key, required this.userName});
  String userName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: GradientBackground(
        child: SafeArea(
          child: Column(
            children: [
              Stack(children: [
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset('assets/images/avatar.svg',
                          width: 30.w, height: 30.h),
                      Text(
                        userName,
                        style: TextStyle(fontSize: 16.sp, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon:
                      const Icon(Icons.arrow_back_ios_new, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
              ]),
              SizedBox(height: 22.h),
              const Divider(
                color: Color.fromARGB(255, 145, 145, 145),
                thickness: 0.5,
                height: 0,
              ),
              Expanded(
                child: ListView(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                  children: [
                    _buildTimeStamp('Yesterday 9:41'),
                    ChatBubble(
                      clipper: ChatBubbleClipper3(type: BubbleType.sendBubble),
                      alignment: Alignment.topRight,
                      shadowColor: Colors.transparent,
                      margin: EdgeInsets.only(top: 20),
                      backGroundColor: Colors.blue,
                      child: Container(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.7,
                        ),
                        child: Text(
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    _buildTimeStamp('Yesterday 9:45'),
                    ChatBubble(
                      clipper:
                          ChatBubbleClipper3(type: BubbleType.receiverBubble),
                      backGroundColor: Color(0xff262628),
                      shadowColor: Colors.transparent,
                      margin: EdgeInsets.only(top: 20),
                      child: Container(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.7,
                        ),
                        child: Text(
                          "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    _buildTimeStamp('Yesterday 9:41'),
                    ChatBubble(
                      clipper: ChatBubbleClipper3(type: BubbleType.sendBubble),
                      alignment: Alignment.topRight,
                      shadowColor: Colors.transparent,
                      margin: EdgeInsets.only(top: 20),
                      backGroundColor: Colors.blue,
                      child: Container(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.7,
                        ),
                        child: Text(
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    _buildTimeStamp('Yesterday 9:45'),
                    ChatBubble(
                      clipper:
                          ChatBubbleClipper3(type: BubbleType.receiverBubble),
                      backGroundColor: Color(0xff262628),
                      shadowColor: Colors.transparent,
                      margin: EdgeInsets.only(top: 20),
                      child: Container(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.7,
                        ),
                        child: Text(
                          "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    _buildTimeStamp('Yesterday 9:41'),
                    ChatBubble(
                      clipper: ChatBubbleClipper3(type: BubbleType.sendBubble),
                      alignment: Alignment.topRight,
                      shadowColor: Colors.transparent,
                      margin: EdgeInsets.only(top: 20),
                      backGroundColor: Colors.blue,
                      child: Container(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.7,
                        ),
                        child: Text(
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    _buildTimeStamp('Yesterday 9:45'),
                    ChatBubble(
                      clipper:
                          ChatBubbleClipper3(type: BubbleType.receiverBubble),
                      backGroundColor: Color(0xff262628),
                      shadowColor: Colors.transparent,
                      margin: EdgeInsets.only(top: 20),
                      child: Container(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.7,
                        ),
                        child: Text(
                          "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              _buildMessageInput(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimeStamp(String text) {
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
        margin: EdgeInsets.symmetric(vertical: 8.h),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: 12.sp, color: Color(0xFFEBEBF5)),
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.w),
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 78, 94, 89),
        borderRadius: BorderRadius.circular(50.r),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 78, 94, 89),
                borderRadius: BorderRadius.circular(24.r),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      style: TextStyle(fontSize: 14.sp),
                      decoration: InputDecoration(
                        icon: Icon(Icons.camera_alt_outlined,
                            color: Colors.white, size: 26.w),
                        hintText: 'Message...',
                        filled: true,
                        fillColor: const Color.fromARGB(255, 78, 94, 89),
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Color(0xFFFFFFFF)),
                      ),
                    ),
                  ),
                  Icon(Icons.mic, color: Colors.white, size: 26.w),
                  SizedBox(width: 8.w),
                  Icon(Icons.image_outlined, color: Colors.white, size: 26.w),
                  SizedBox(width: 8.w),
                  Icon(Icons.add_circle_outline_outlined,
                      color: Colors.white, size: 30.w),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
