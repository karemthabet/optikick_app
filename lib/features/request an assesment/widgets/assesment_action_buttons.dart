import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:optikick/core/utils/colors.dart';
import 'package:optikick/features/request%20an%20assesment/presentation/cubits/approve_assesment_cubit/approve_assesment_cubit.dart';
import 'package:optikick/features/request%20an%20assesment/presentation/cubits/approve_assesment_cubit/approve_assesmet_states.dart';
import 'package:optikick/features/request%20an%20assesment/presentation/views/reschedule_assesment_view.dart';

class AssesmentActionButtons extends StatelessWidget {
  const AssesmentActionButtons({
    super.key,
    required this.assesmentID,
  });
  final int assesmentID;
  @override
  Widget build(BuildContext context) {
    return BlocListener<ApproveAndScheduleAssesmentCubit,
        ApproveAssesmetStates>(
      listener: (context, state) {
        if (state is ApproveAssesmetSuccess) {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.success,
            animType: AnimType.topSlide,
            title: 'Approved',
            desc: 'Assessment approved successfully',
          ).show();
        }
        if (state is AssesmetFailure) {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            animType: AnimType.topSlide,
            title: 'Error',
            desc: state.errMessage,
          ).show();
        }
        if (state is ApproveAssesmetLoading) {
          showDialog(
            context: context,
            builder: (_) => Center(
              child: CircularProgressIndicator(
                color: ColorsManager.realGreyColor,
              ),
            ),
          );
        }
      },
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                context
                    .read<ApproveAndScheduleAssesmentCubit>()
                    .approveAssesment(assesmentID);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Text(
                    'Approve',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 50.w),
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RescheduleAssesmentView(
                      assementId: assesmentID,
                    ),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: const Color(0xFF303030),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Text(
                    'Postpone',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
