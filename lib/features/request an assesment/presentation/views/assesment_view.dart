import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:optikick/core/utils/colors.dart';
import '../../../../core/widgets/gradient_background.dart';
import '../../widgets/assesments_view_body.dart';
import '../cubits/getassements_cubit/assesment_cubit.dart';

class AssesmentView extends StatelessWidget {
  const AssesmentView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AssesmentCubit()..getAllAssesment(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: ColorsManager.backgroundColor,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded,
                color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            'Assessment Requests',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: GradientBackground(
          child: AssesmentViewBody(),
        ),
      ),
    );
  }
}
