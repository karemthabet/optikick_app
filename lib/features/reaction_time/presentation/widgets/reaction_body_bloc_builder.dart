import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../core/widgets/gradient_background.dart';
import '../cubit/metric_cubit.dart';
import '../cubit/metric_cubit_state.dart';
import 'custom_container.dart';
import 'custom_curve_chart.dart';

class ReactionBodyBlocBuilder extends StatelessWidget {
  const ReactionBodyBlocBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MetricCubit, MetricCubitState>(
      builder: (context, state) {
        if (state is MetricCubitError) {
          return GradientBackground(
            child: Center(
              child: Text(state.errorMessage),
            ),
          );
        }
        if (state is MetricCubitLoaded) {
          return SingleChildScrollView(
            child: Column(
              children: [
                CustomCurveChart(graphDataModel: state.graphDataModel),
                const SizedBox(height: 24),
                CustomContainer(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Highlights',
                        style: TextStyle(
                          fontSize: 17.sp,
                          fontWeight: FontWeight.normal,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: CustomContainer(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Symbols.vital_signs,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    state.graphDataModel.metricType!,
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                state.graphDataModel.highlights!,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
        return Padding(
          padding: const EdgeInsets.only(top: 80),
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
