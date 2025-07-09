import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:optikick/core/keys/end_ponits.dart';
import 'package:optikick/core/routes/routes.dart';
import 'package:optikick/core/services/cache_helper.dart';
import 'package:optikick/core/utils/colors.dart';
import 'package:optikick/features/bottom_nav/presentation/views/widgets/sidebar_tile.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 4, 21, 10),
              Color.fromARGB(255, 40, 59, 52),
              Color(0xff5D6E68),
            ],
            stops: [0.0, 0.7, 1.0],
          ),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.account_circle,
                    size: 30.h,
                    color: ColorsManager.textIconColor,
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    "${CacheHelper.getData(key: ApiKey.firstName)}${CacheHelper.getData(key: ApiKey.lastName)}",
                    style: TextStyle(
                      fontSize: 17.sp,
                      color: ColorsManager.realWhiteColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "${CacheHelper.getData(key: ApiKey.email)}",
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: ColorsManager.realWhiteColor,
                    ),
                  ),
                ],
              ),
            ),
            SidebarTile(
              title: 'Profile',
              icon: Icons.person_2_outlined,
              onTap: () {
                Navigator.pushNamed(context, RoutesName.profile);
              },
            ),
            SidebarTile(
              title: 'Stats',
              icon: Symbols.vital_signs,
              onTap: () {
                CacheHelper.getData(key: ApiKey.isPlayer)
                    ? Navigator.pushNamed(context, RoutesName.playerStats)
                    : Navigator.pushNamed(context, RoutesName.stats);
              },
            ),
            SidebarTile(
              title: 'Training Program',
              icon: Icons.assignment_outlined,
              onTap: () {
                CacheHelper.getData(key: ApiKey.isPlayer)
                    ? Navigator.pushNamed(context, RoutesName.playerView)
                    : Navigator.pushNamed(context, RoutesName.trainingProgram);
              },
            ),
            CacheHelper.getData(key: ApiKey.role) != ApiKey.coachRole
                ? SidebarTile(
                    title: CacheHelper.getData(key: ApiKey.isPlayer)
                        ? 'Request an Assessment'
                        : 'Assessment Requests', //?view to players and doctor only
                    icon: Symbols.stethoscope,
                    iconColor: ColorsManager.textIconColor,
                    onTap: () {
                      if (CacheHelper.getData(key: ApiKey.role) ==
                          ApiKey.playerRole) {
                        Navigator.pushNamed(
                            context, RoutesName.submitNewAssesmentRequest);
                      } // as PLayerView;
                      else {
                        Navigator.pushNamed(
                            context, RoutesName.viewAllAssessmentRequests);
                      }
                    },
                  )
                : const SizedBox(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: SizedBox(
                width: 90.w,
                child: const Divider(
                  color: ColorsManager.realGreyColor,
                  thickness: 0.5,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.settings,
                color: ColorsManager.textIconColor,
              ),
              title: const Text(
                'Settings & Privacy',
                style: TextStyle(color: ColorsManager.realWhiteColor),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.help_outline,
                color: ColorsManager.textIconColor,
              ),
              title: const Text(
                'Help Centre',
                style: TextStyle(color: ColorsManager.realWhiteColor),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.exit_to_app_outlined,
                color: ColorsManager.textIconColor,
              ),
              title: const Text(
                'Log Out',
                style: TextStyle(color: ColorsManager.realWhiteColor),
              ),
              onTap: () {
                // Handle logout
              },
            ),
          ],
        ),
      ),
    );
  }
}
