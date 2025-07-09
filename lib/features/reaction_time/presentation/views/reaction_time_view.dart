import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:optikick/core/widgets/gradient_background.dart';
import 'package:optikick/features/reaction_time/data/models/graph_data_model.dart';
import 'package:optikick/features/reaction_time/presentation/cubit/metric_cubit.dart';
import 'package:optikick/features/reaction_time/presentation/widgets/custom_tab_selector.dart';
import '../widgets/reaction_body_bloc_builder.dart';

class ReactionTimeView extends StatelessWidget {
  const ReactionTimeView({
    super.key,
    required this.metricType,
  });
  final String metricType;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          MetricCubit()..getPlayerMetric(mericType: metricType, period: "D"),
      child: Builder(builder: (context) {
        return Scaffold(
          body: ReactionViewBody(
              graphDataModel: GraphDataModel(metricType: metricType)),
        );
      }),
    );
  }
}

class ReactionViewBody extends StatelessWidget {
  const ReactionViewBody({
    super.key,
    required this.graphDataModel,
  });
  final GraphDataModel graphDataModel;

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        graphDataModel.metricType!,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    padding: const EdgeInsets.only(bottom: 30),
                    icon: const Icon(Icons.arrow_back_ios_new,
                        color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ],
            ),
            const Divider(
              color: Color.fromARGB(255, 145, 145, 145),
              thickness: 0.5,
              height: 0,
            ),
            Expanded(
              child: Column(
                children: [
                  SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: CustomTabSelector(
                            mericType: graphDataModel.metricType!,
                          ),
                        ),
                        const SizedBox(height: 24),
                        ReactionBodyBlocBuilder(),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
