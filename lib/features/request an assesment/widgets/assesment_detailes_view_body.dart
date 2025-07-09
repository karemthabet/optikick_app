import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optikick/core/widgets/gradient_background.dart';
import 'package:optikick/features/request%20an%20assesment/presentation/cubits/getassements_cubit/assesment_cubit.dart';
import 'package:optikick/features/request%20an%20assesment/widgets/assesment_details_item.dart';

import '../presentation/cubits/getassements_cubit/assement_cubit_state.dart';

class AssesmentDetailesViewBody extends StatelessWidget {
  const AssesmentDetailesViewBody({
    super.key,
    required this.playerPacientName,
    required this.assementId,
  });
  final String playerPacientName;
  final int assementId;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AssesmentCubit, AssesmentCubitState>(
      builder: (context, state) {
        if (state is AssesmentFailure) {
          return Center(child: Text(state.errMessage));
        }
        if (state is AssesmentDetailsSuccess) {
          return AssesmentDetailesItem(
            assessmentWithDetailsModel: state.assesmentDetails,
            playerPacientName: playerPacientName,
            assesmentId: assementId,
          );
        }
        return const Center(
            child: GradientBackground(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ));
      },
    );
  }
}
