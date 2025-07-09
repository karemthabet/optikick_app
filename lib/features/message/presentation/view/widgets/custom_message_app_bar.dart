import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomMessageAppBar extends StatelessWidget {
  CustomMessageAppBar({
    super.key,
  });

  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 6.h),
          child: TextFormField(
            controller: _searchController,
            style: TextStyle(color: const Color(0xff808080), fontSize: 14.sp),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 0),
              filled: true,
              fillColor: const Color.fromARGB(64, 44, 61, 29),
              hintText: 'Search Direct Messages',
              hintStyle:
                  TextStyle(color: const Color(0xff808080), fontSize: 14.sp),
              prefixIcon: const Icon(Icons.search, color: Color(0xff808080)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(100),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        const Divider(
          color: Color.fromARGB(255, 145, 145, 145),
          thickness: 0.5,
          height: 0,
        ),
      ],
    );
  }
}
