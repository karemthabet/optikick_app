import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:optikick/core/utils/colors.dart';

class PlayerItem extends StatelessWidget {
  const PlayerItem({
    super.key,
    required this.title,
    this.toDo,
    this.height = 110,
  });

  final String title;
  final String? toDo;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height.h,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromARGB(255, 4, 21, 10),
            Color(0xff5D6E68),
          ],
        ),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: ColorsManager.realWhiteColor,
          width: 0.2.w,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 35.h,
                width: 35.w,
                child: Icon(
                  Symbols.assignment,
                  size: 30.h,
                  color: ColorsManager.textIconColor,
                ),
              ),
              SizedBox(width: 20.w),
              Expanded(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: ColorsManager.realWhiteColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          if (toDo != null && toDo!.isNotEmpty)
            Padding(
              padding: EdgeInsets.only(left: 55.w, top: 6.h),
              child: Text(
                textAlign: TextAlign.center,
                toDo!,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 15.sp,
                  color: ColorsManager.realWhiteColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
