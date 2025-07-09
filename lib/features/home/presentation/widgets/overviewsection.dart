import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:optikick/core/keys/end_ponits.dart';
import 'package:optikick/core/services/cache_helper.dart';
import 'package:optikick/features/home/presentation/cubit/dash_board_cubit.dart';
import 'package:optikick/features/home/presentation/widgets/custom_clip_path.dart';

// ignore: must_be_immutable
class OverviewSection extends StatelessWidget {
  OverviewSection({super.key});
  bool isPlayer = CacheHelper.getData(key: ApiKey.role) == ApiKey.playerRole;

  @override
  Widget build(BuildContext context) {
    if (isPlayer) {
      BlocProvider.of<DashBoardCubit>(context).getPlayerDashboard();
    } else {
      BlocProvider.of<DashBoardCubit>(context).getAdminDashboard();
    }

    return BlocConsumer<DashBoardCubit, DashBoardState>(
      listener: (context, state) {
        if (state is DashFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errMessage),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        return state is DashLoading
            ? Center(
                child: CircularProgressIndicator(
                  color: Color.fromARGB(255, 97, 103, 87),
                ),
              )
            : SingleChildScrollView(
                child: ClipPath(
                  clipper: MyClipperPath(),
                  child: Container(
                    height: 210.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.4),
                          offset: Offset(2, 22),
                          blurRadius: 30,
                          spreadRadius: 5,
                        ),
                      ],
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.2),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color.fromARGB(255, 4, 21, 10),
                          Color.fromARGB(255, 40, 59, 52),
                          Color(0xff5D6E68),
                        ],
                        stops: [0.0, 0.7, 1.0],
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.2),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                            color: Colors.transparent,
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(12),
                                child: Text(
                                  "Overview",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 16),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 120.h,
                              width: 120.w,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  RingPieChart(
                                    lightBlueValue: isPlayer
                                        ? (BlocProvider.of<DashBoardCubit>(
                                                    context)
                                                .playerMetrics!
                                                .restingHr
                                                .value as num)
                                            .toDouble()
                                        : (BlocProvider.of<DashBoardCubit>(
                                                    context)
                                                .adminOverview!
                                                .optimal
                                                .percentage as num)
                                            .toDouble(),
                                    indigoValue: isPlayer
                                        ? (BlocProvider.of<DashBoardCubit>(
                                                    context)
                                                .playerMetrics!
                                                .maxHr
                                                .value as num)
                                            .toDouble()
                                        : (BlocProvider.of<DashBoardCubit>(
                                                    context)
                                                .adminOverview!
                                                .atRisk
                                                .percentage as num)
                                            .toDouble(),
                                    deepPurpleValue: isPlayer
                                        ? (BlocProvider.of<DashBoardCubit>(
                                                    context)
                                                .playerMetrics!
                                                .hrv
                                                .value as num)
                                            .toDouble()
                                        : (BlocProvider.of<DashBoardCubit>(
                                                    context)
                                                .adminOverview!
                                                .underperforming
                                                .percentage as num)
                                            .toDouble(),
                                    blueValue: isPlayer
                                        ? (BlocProvider.of<DashBoardCubit>(
                                                    context)
                                                .playerMetrics!
                                                .vo2Max
                                                .value as num)
                                            .toDouble()
                                        : (BlocProvider.of<DashBoardCubit>(
                                                    context)
                                                .adminOverview!
                                                .recovering
                                                .percentage as num)
                                            .toDouble(),
                                  ),
                                  Positioned(
                                    child: Icon(
                                      Symbols.group,
                                      size: 30.h,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 16.w),
                            Expanded(
                              child: SizedBox(
                                height: 120.h,
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      StatRow(
                                        isPlayer: isPlayer,
                                        color: Colors.lightBlue,
                                        label: isPlayer
                                            ? "Resting Heart Rate"
                                            : "Optimal",
                                        firstVal: isPlayer
                                            ? BlocProvider.of<DashBoardCubit>(
                                                    context)
                                                .playerMetrics!
                                                .restingHr
                                                .value
                                                .toString()
                                            : BlocProvider.of<DashBoardCubit>(
                                                    context)
                                                .adminOverview!
                                                .optimal
                                                .percentage
                                                .toString(),
                                        secondVal: isPlayer
                                            ? BlocProvider.of<DashBoardCubit>(
                                                    context)
                                                .playerMetrics!
                                                .restingHr
                                                .unit
                                                .toString()
                                            : BlocProvider.of<DashBoardCubit>(
                                                    context)
                                                .adminOverview!
                                                .optimal
                                                .count
                                                .toString(),
                                      ),
                                      StatRow(
                                        isPlayer: isPlayer,
                                        color: Color(0xFF1A237E),
                                        label: isPlayer
                                            ? "Max Heart Rate"
                                            : "Risk",
                                        firstVal: isPlayer
                                            ? BlocProvider.of<DashBoardCubit>(
                                                    context)
                                                .playerMetrics!
                                                .maxHr
                                                .value
                                                .toString()
                                            : BlocProvider.of<DashBoardCubit>(
                                                    context)
                                                .adminOverview!
                                                .atRisk
                                                .percentage
                                                .toString(),
                                        secondVal: isPlayer
                                            ? BlocProvider.of<DashBoardCubit>(
                                                    context)
                                                .playerMetrics!
                                                .maxHr
                                                .unit
                                                .toString()
                                            : BlocProvider.of<DashBoardCubit>(
                                                    context)
                                                .adminOverview!
                                                .atRisk
                                                .count
                                                .toString(),
                                      ),
                                      StatRow(
                                        isPlayer: isPlayer,
                                        color: Colors.deepPurple,
                                        label: isPlayer
                                            ? "HRV"
                                            : "Underperforming",
                                        firstVal: isPlayer
                                            ? BlocProvider.of<DashBoardCubit>(
                                                    context)
                                                .playerMetrics!
                                                .hrv
                                                .value
                                                .toString()
                                            : BlocProvider.of<DashBoardCubit>(
                                                    context)
                                                .adminOverview!
                                                .underperforming
                                                .percentage
                                                .toString(),
                                        secondVal: isPlayer
                                            ? BlocProvider.of<DashBoardCubit>(
                                                    context)
                                                .playerMetrics!
                                                .hrv
                                                .unit
                                                .toString()
                                            : BlocProvider.of<DashBoardCubit>(
                                                    context)
                                                .adminOverview!
                                                .underperforming
                                                .count
                                                .toString(),
                                      ),
                                      StatRow(
                                        isPlayer: isPlayer,
                                        color: Color(0xFF1E88E5),
                                        label:
                                            isPlayer ? "VO2 Max" : "Recovering",
                                        firstVal: isPlayer
                                            ? BlocProvider.of<DashBoardCubit>(
                                                    context)
                                                .playerMetrics!
                                                .vo2Max
                                                .value
                                                .toString()
                                            : BlocProvider.of<DashBoardCubit>(
                                                    context)
                                                .adminOverview!
                                                .underperforming
                                                .percentage
                                                .toString(),
                                        secondVal: isPlayer
                                            ? BlocProvider.of<DashBoardCubit>(
                                                    context)
                                                .playerMetrics!
                                                .vo2Max
                                                .unit
                                                .toString()
                                            : BlocProvider.of<DashBoardCubit>(
                                                    context)
                                                .adminOverview!
                                                .underperforming
                                                .count
                                                .toString(),
                                      ),

                                      // Add more if needed
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        // Stats column
                      ],
                    ),
                  ),
                ),
              );
      },
    );
  }
}

class StatRow extends StatelessWidget {
  final Color color;
  final String label;
  final String firstVal;
  final String secondVal;
  final bool isPlayer;

  const StatRow({
    super.key,
    required this.color,
    required this.label,
    required this.firstVal,
    required this.secondVal,
    required this.isPlayer,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.w),
      child: Row(
        children: [
          Container(
            width: 10.w,
            height: 10.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
            ),
          ),
          SizedBox(width: 6.w),
          Expanded(
            child: Text(
              label,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.white, fontSize: 13.sp),
            ),
          ),
          Text(
            isPlayer ? '($firstVal)' : '$firstVal%',
            style: TextStyle(color: Colors.white, fontSize: 12.sp),
          ),
          SizedBox(width: 4.w),
          Text(
            isPlayer ? secondVal : "($secondVal)",
            style: TextStyle(color: Colors.white54, fontSize: 12.sp),
          ),
        ],
      ),
    );
  }
}

class RingPieChart extends StatelessWidget {
  final double lightBlueValue;
  final double indigoValue;
  final double deepPurpleValue;
  final double blueValue;

  const RingPieChart({
    super.key,
    required this.lightBlueValue,
    required this.indigoValue,
    required this.deepPurpleValue,
    required this.blueValue,
  });

  static const double radius = 18;
  static const double centerSpaceRadius = 40;
  static const double size = 120;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: PieChart(
        PieChartData(
          startDegreeOffset: -90,
          sectionsSpace: 0,
          centerSpaceRadius: centerSpaceRadius,
          sections: [
            PieChartSectionData(
              value: lightBlueValue,
              color: Colors.lightBlue,
              radius: radius,
              showTitle: false,
            ),
            PieChartSectionData(
              value: indigoValue,
              color: Colors.indigo[800], // default is [500]
              radius: radius,
              showTitle: false,
            ),
            PieChartSectionData(
              value: deepPurpleValue,
              color: Colors.deepPurple,
              radius: radius,
              showTitle: false,
            ),
            PieChartSectionData(
              value: blueValue,
              color: Colors.blue[600], // default is [500]
              radius: radius,
              showTitle: false,
            ),
          ],
        ),
      ),
    );
  }
}
