import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:optikick/core/utils/colors.dart';
import 'package:optikick/core/widgets/gradient_background.dart';
import 'package:optikick/features/request%20an%20assesment/data/models/assesments_with_detailes.dart';
import 'package:optikick/features/request%20an%20assesment/presentation/views/assessment_request_details.dart';
import 'assesment_action_buttons.dart';

class AssesmentDetailesItem extends StatelessWidget {
  const AssesmentDetailesItem({
    super.key,
    required this.assessmentWithDetailsModel,
    required this.playerPacientName,
    required this.assesmentId,
  });

  final AssessmentWithDetailsModel assessmentWithDetailsModel;
  final String playerPacientName;
  final int assesmentId;
  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: ListView(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left Icon Column
                Column(
                  children: [
                    Icon(
                      Symbols.stethoscope,
                      color: ColorsManager.textIconColor,
                      size: 48.sp,
                    ),
                  ],
                ),
                SizedBox(width: 16.w),
                // Right Content Column
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        playerPacientName,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      const Label(text: 'Issue Type'),
                      InfoBox(text: assessmentWithDetailsModel.issueType),
                      SizedBox(height: 12.h),
                      const Label(text: 'Date'),
                      InfoBox(text: assessmentWithDetailsModel.date),
                      SizedBox(height: 12.h),
                      const Label(text: 'Hour'),
                      InfoBox(text: assessmentWithDetailsModel.hour),
                      SizedBox(height: 12.h),
                      const Label(text: 'Message'),
                      InfoBox(
                        text: assessmentWithDetailsModel.message,
                        isMultiline: true,
                      ),
                      SizedBox(height: 30.h),
                      AssesmentActionButtons(
                        assesmentID: assesmentId,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
