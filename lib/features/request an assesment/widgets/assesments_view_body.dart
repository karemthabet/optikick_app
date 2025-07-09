import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optikick/features/request%20an%20assesment/presentation/cubits/getassements_cubit/assement_cubit_state.dart';

import '../presentation/cubits/getassements_cubit/assesment_cubit.dart';
import 'assessment_item.dart';

class AssesmentViewBody extends StatelessWidget {
  const AssesmentViewBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AssesmentCubit, AssesmentCubitState>(
      builder: (context, state) {
        if (state is AssesmentFailure) {
          return Center(child: Text(state.errMessage));
        }
        if (state is AssesmentSuccess) {
          return ListView.separated(
            physics: const BouncingScrollPhysics(),
            separatorBuilder: (context, index) => Divider(
              color: Colors.white.withValues(alpha: 0.2),
              height: 1,
            ),
            itemCount: state.miniAssesments.length,
            itemBuilder: (context, index) {
              return AssessmentItem(
                miniAssessmentModel: state.miniAssesments[index],
              );
            },
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
