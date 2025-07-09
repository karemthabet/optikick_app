import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:optikick/core/constants/assets.dart';
import 'package:optikick/core/utils/colors.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    required this.currentIndex,
  });

  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorsManager.backgroundColor,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(12.w, 0, 12.w, 5.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Builder(
                  builder: (BuildContext context) {
                    return IconButton(
                      icon: const Icon(
                        Icons.account_circle,
                        color: ColorsManager.realWhiteColor,
                        size: 30,
                      ),
                      tooltip: 'Open Menu',
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                    );
                  },
                ),
                Expanded(
                  child: Center(
                      child: currentIndex == 0
                          ? SizedBox(
                              height: 35.h,
                              child: Image.asset(Assets.imagesLogoTest),
                            )
                          : Text(
                              currentIndex == 1 ? "Notifications" : "Messages",
                              style: TextStyle(
                                fontSize: 20.sp,
                                color: ColorsManager.realWhiteColor,
                              ),
                            )),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.settings_outlined,
                    color: ColorsManager.realWhiteColor,
                    size: 30,
                  ),
                  tooltip: 'settings',
                  onPressed: () {},
                ),
              ],
            ),
          ),
          currentIndex != 2
              ? Divider(
                  color: const Color.fromARGB(255, 145, 145, 145),
                  thickness: .5,
                  height: 0,
                )
              : SizedBox()
        ],
      ),
    );
  }
}
