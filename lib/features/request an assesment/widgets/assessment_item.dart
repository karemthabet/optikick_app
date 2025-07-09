import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:optikick/core/utils/colors.dart';
import 'package:optikick/features/request%20an%20assesment/data/models/mini_assesment_model.dart';
import 'package:optikick/features/request%20an%20assesment/presentation/views/assessment_request_details.dart';

class AssessmentItem extends StatelessWidget {
  const AssessmentItem({
    super.key,
    required this.miniAssessmentModel,
  });
  final MiniAssessmentModel miniAssessmentModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon inside a column
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Symbols.stethoscope,
                    color: ColorsManager.textIconColor,
                    size: 48.sp,
                  ),
                ],
              ),
              SizedBox(width: 15.w),
              // Text and button section
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${miniAssessmentModel.firstName} ${miniAssessmentModel.lastName}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: "${miniAssessmentModel.message} ",
                          ),
                          TextSpan(
                            text: miniAssessmentModel.requestedAt
                                .toString()
                                .split(' ')[0],
                            style: const TextStyle(),
                          ),
                        ],
                      ),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 15.h),
                    SizedBox(
                      width: double.infinity,
                      height: 36.h,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AssessmentDetailsView(
                                  assessmentId: miniAssessmentModel.id,
                                  playerPacintName:
                                      "${miniAssessmentModel.firstName} ${miniAssessmentModel.lastName}",
                                ),
                              ));
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: const Color(0xFF191E26),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                            side: const BorderSide(
                              color: Colors.white,
                              width: 0.2,
                            ),
                          ),
                          padding: EdgeInsets.zero,
                        ),
                        child: Center(
                          child: Text(
                            'See More',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
