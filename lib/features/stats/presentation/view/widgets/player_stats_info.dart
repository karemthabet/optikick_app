import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:optikick/core/utils/colors.dart';

class PlayerStatsInfo extends StatelessWidget {
  const PlayerStatsInfo(
      {super.key,
      required this.title,
      required this.statusValueType,
      required this.time,
      required this.statusValue});

  final String title;
  final String statusValueType;
  final String time;
  final String statusValue;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
          height: 100.h,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(255, 4, 21, 10),
                // Color.fromARGB(255, 40, 59, 52),
                Color(0xff5D6E68),
              ],
              stops: [0.0, 0.9],
            ),
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(
              color: ColorsManager.realWhiteColor,
              width: 0.2.w,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                        height: 35.h,
                        width: 35.w,
                        child: SvgPicture.asset(
                          "assets/images/Activity.svg",
                          fit: BoxFit.fill,
                        )),
                    SizedBox(
                      width: 8.w,
                    ),
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: ColorsManager.realWhiteColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      time,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: ColorsManager.realWhiteColor,
                        fontWeight: FontWeight.w100,
                      ),
                    ),
                    SizedBox(
                      width: 4.w,
                    ),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: ColorsManager.realWhiteColor,
                      size: 18.sp,
                    ),
                  ],
                ),
                Spacer(),
                Row(
                  children: [
                    Text(
                      statusValue,
                      style: TextStyle(
                        fontSize: 30.sp,
                        color: ColorsManager.realWhiteColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    Text(
                      statusValueType,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: ColorsManager.realWhiteColor,
                        fontWeight: FontWeight.w100,
                      ),
                    ),
                    const Spacer(),
                    SvgPicture.asset(
                      "assets/images/bar_chart.svg",
                      height: 45.h,
                      width: 45.w,
                    )
                  ],
                ),
              ],
            ),
          ))
    ]);
  }
}
