import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:optikick/core/utils/colors.dart';
import 'package:optikick/features/request%20an%20assesment/presentation/cubits/getassements_cubit/assesment_cubit.dart';
import 'package:optikick/features/request%20an%20assesment/widgets/assesment_detailes_view_body.dart';

import '../cubits/approve_assesment_cubit/approve_assesment_cubit.dart';

// ignore: must_be_immutable
class AssessmentDetailsView extends StatelessWidget {
  const AssessmentDetailsView(
      {super.key, required this.assessmentId, required this.playerPacintName});
  final int assessmentId;
  final String playerPacintName;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              AssesmentCubit()..getAssesmentDetailes(assessmentId),
        ),
        BlocProvider(
          create: (context) => ApproveAndScheduleAssesmentCubit(),
        ),
      ],
      child: Builder(builder: (context) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: ColorsManager.backgroundColor,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded,
                  color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(
              'Assessment Details',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
          ),
          body: AssesmentDetailesViewBody(
            playerPacientName: playerPacintName,
            assementId: assessmentId,
          ),
        );
      }),
    );
  }
}

class Label extends StatelessWidget {
  final String text;
  const Label({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.h, bottom: 4.h),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class InfoBox extends StatelessWidget {
  final String text;
  final bool isMultiline;
  const InfoBox({super.key, required this.text, this.isMultiline = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: 15.w,
        vertical: isMultiline ? 15.h : 12.h,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF191E26),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
      ),
      child: Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.sp,
          ),
          maxLines: isMultiline ? 5 : 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
