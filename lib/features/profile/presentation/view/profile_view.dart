import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:optikick/core/keys/end_ponits.dart';
import 'package:optikick/core/services/cache_helper.dart';
import 'package:optikick/core/utils/colors.dart';
import 'package:optikick/features/profile/cubit/profile_cubit.dart';
import 'package:optikick/features/profile/presentation/widgets/info_item.dart';

// ignore: must_be_immutable
class ProfileView extends StatelessWidget {
  ProfileView({super.key});
  bool isNotPlayer = CacheHelper.getData(key: ApiKey.role) != ApiKey.playerRole;

  bool isDoctor = CacheHelper.getData(key: ApiKey.role) == ApiKey.doctorRole;
  bool isCoach = CacheHelper.getData(key: ApiKey.role) == ApiKey.coachRole;

  @override
  Widget build(BuildContext context) {
    if (isNotPlayer) {
      if (isDoctor) {
        BlocProvider.of<ProfileCubit>(context).getDoctorProfile();
      } else {
        BlocProvider.of<ProfileCubit>(context).getCoachProfile();
      }
    } else {
      BlocProvider.of<ProfileCubit>(context).getPlayerProfile();
    }
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ProfileFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errMessage),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        return state is ProfileLoading
            ? Container(
                height: double.infinity,
                width: double.infinity,
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
                ),
                child: const Center(
                  child: CircularProgressIndicator(
                    color: Color.fromARGB(255, 97, 103, 87),
                  ),
                ),
              )
            : Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xff102418),
                      Color.fromARGB(255, 40, 59, 52),
                      Color(0xff566761),
                    ],
                    stops: [0.0, 0.5, 0.9],
                  ),
                ),
                child: Scaffold(
                  appBar: AppBar(
                    centerTitle: true,
                    backgroundColor: ColorsManager.backgroundColor,
                    elevation: 0,
                    leading: IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: ColorsManager.realWhiteColor,
                        size: 20.sp,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    title: Text(
                      "Profile",
                      style: TextStyle(
                        fontSize: 18.sp,
                        color: ColorsManager.realWhiteColor,
                      ),
                    ),
                  ),
                  backgroundColor: Colors.transparent,
                  body: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                color: Colors.transparent,
                                child: Icon(
                                  Icons.account_circle_rounded,
                                  color: ColorsManager.realWhiteColor,
                                  size: 60.sp,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 18.h,
                          ),
                          PersonalInfoItem(
                              firstTitle: "First Name",
                              firstValue: BlocProvider.of<ProfileCubit>(context)
                                      .profileModel
                                      ?.firstName
                                      ?.toString() ??
                                  '',
                              secondTitle: "Last Name",
                              secondValue:
                                  BlocProvider.of<ProfileCubit>(context)
                                          .profileModel
                                          ?.lastName
                                          ?.toString() ??
                                      ''),
                          SizedBox(
                            height: 18.h,
                          ),
                          PersonalInfoItem(
                              firstTitle: "Date of Birth",
                              firstValue: BlocProvider.of<ProfileCubit>(context)
                                      .profileModel
                                      ?.dateOfBirth
                                      ?.toString() ??
                                  '',
                              secondTitle: "Sex",
                              secondValue:
                                  BlocProvider.of<ProfileCubit>(context)
                                          .profileModel
                                          ?.sex
                                          ?.toString() ??
                                      ''),
                          SizedBox(
                            height: 18.h,
                          ),
                          PersonalInfoItem(
                              firstTitle:
                                  isDoctor || isCoach ? "Position" : "Status",
                              firstValue: isDoctor || isCoach
                                  ? BlocProvider.of<ProfileCubit>(context)
                                          .profileModel
                                          ?.position
                                          ?.toString() ??
                                      ''
                                  : BlocProvider.of<ProfileCubit>(context)
                                          .profileModel
                                          ?.status
                                          ?.toString() ??
                                      '',
                              secondTitle: isDoctor || isCoach
                                  ? "Blood Type"
                                  : "Position",
                              secondValue: isDoctor || isCoach
                                  ? BlocProvider.of<ProfileCubit>(context)
                                          .profileModel
                                          ?.bloodType
                                          ?.toString() ??
                                      ''
                                  : BlocProvider.of<ProfileCubit>(context)
                                          .profileModel
                                          ?.position
                                          ?.toString() ??
                                      ''),
                          SizedBox(
                            height: 18.h,
                          ),
                          isDoctor || isCoach
                              ? Container(
                                  height: 60.h,
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
                                    padding: const EdgeInsets.all(16),
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: Row(
                                            children: [
                                              Text(
                                                "Email",
                                                style: TextStyle(
                                                  fontSize: 16.sp,
                                                  color: ColorsManager
                                                      .realWhiteColor,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              const Spacer(),
                                              Text(
                                                BlocProvider.of<ProfileCubit>(
                                                            context)
                                                        .profileModel
                                                        ?.email
                                                        ?.toString() ??
                                                    '',
                                                style: TextStyle(
                                                  fontSize: 16.sp,
                                                  color: ColorsManager
                                                      .realWhiteColor,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : PersonalInfoItem(
                                  firstTitle: "Blood Type",
                                  firstValue:
                                      BlocProvider.of<ProfileCubit>(context)
                                              .profileModel
                                              ?.bloodType
                                              ?.toString() ??
                                          '',
                                  secondTitle: "Email",
                                  secondValue:
                                      BlocProvider.of<ProfileCubit>(context)
                                              .profileModel
                                              ?.email
                                              ?.toString() ??
                                          ''),
                          SizedBox(
                            height: 18.h,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
      },
    );
  }
}
