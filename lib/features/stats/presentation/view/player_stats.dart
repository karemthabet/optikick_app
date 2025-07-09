import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:optikick/core/api/api_consumer.dart';
import 'package:optikick/core/keys/end_ponits.dart';
import 'package:optikick/core/services/cache_helper.dart';
import 'package:optikick/core/utils/colors.dart';
import 'package:optikick/features/reaction_time/presentation/views/reaction_time_view.dart';
import 'package:optikick/features/stats/presentation/view/widgets/player_stats_info.dart';

class PlayerStats extends StatefulWidget {
  final ApiConsumer api;
  final int? playerId;
  final String? playerName;

  const PlayerStats(
      {super.key, required this.api, this.playerId, this.playerName});

  @override
  State<PlayerStats> createState() => _PlayerStatsState();
}

class _PlayerStatsState extends State<PlayerStats> {
  late Future<PlayerMetric?> metricFuture;
  String _playerName = "";

  @override
  void initState() {
    super.initState();
    metricFuture = fetchMetric(widget.api);
    _playerName = widget.playerName ?? "";
  }

  Future<PlayerMetric?> fetchMetric(ApiConsumer api) async {
    try {
      if (CacheHelper.getData(key: ApiKey.isPlayer)) {
        final response = await api.get(EndPoint.playerMetrics);
        return PlayerMetric.fromJson(response['data']['metric']);
      } else {
        final response = await api.get(CacheHelper.getData(key: ApiKey.isDoctor)
            ? 'doctor/players/${widget.playerId}/metrics'
            : 'coach/players/${widget.playerId}/metrics');
        _playerName = response['data']['player']['name'];
        return PlayerMetric.fromJson(response['data']['metric']);
      }
    } catch (e) {
      throw Exception('Failed to load metrics: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xff102418),
            Color.fromARGB(255, 40, 59, 52),
            Color(0xff566761),
          ],
          stops: [0.0, 0.5, 0.9],
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: ColorsManager.backgroundColor,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: ColorsManager.realWhiteColor,
              size: 20.sp,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            _playerName,
            style:
                TextStyle(fontSize: 18.sp, color: ColorsManager.realWhiteColor),
          ),
        ),
        backgroundColor: Colors.transparent,
        body: FutureBuilder<PlayerMetric?>(
          future: metricFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: CircularProgressIndicator(
                color: Color.fromARGB(255, 97, 103, 87),
              ));
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            }

            final metric = snapshot.data;

            if (metric == null) {
              return Center(
                child: Text(
                  "No metrics available.",
                  style: TextStyle(
                      color: ColorsManager.realWhiteColor, fontSize: 16.sp),
                ),
              );
            }
            return SingleChildScrollView(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ReactionTimeView(
                            metricType: "resting_hr",
                          ),
                        ),
                      );
                    },
                    child: PlayerStatsInfo(
                      title: 'Resting Heart Rate',
                      statusValue: metric.restingHr.value.toString(),
                      statusValueType: metric.restingHr.unit,
                      time: metric.restingHr.time,
                    ),
                  ),
                  SizedBox(height: 14.h),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ReactionTimeView(
                            metricType: "max_hr",
                          ),
                        ),
                      );
                    },
                    child: PlayerStatsInfo(
                      title: 'Max Heart Rate',
                      statusValue: metric.maxHr.value.toString(),
                      statusValueType: metric.maxHr.unit,
                      time: metric.maxHr.time,
                    ),
                  ),
                  SizedBox(height: 14.h),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ReactionTimeView(
                            metricType: "hrv",
                          ),
                        ),
                      );
                    },
                    child: PlayerStatsInfo(
                      title: 'HRV',
                      statusValue: metric.hrv.value.toString(),
                      statusValueType: metric.hrv.unit,
                      time: metric.hrv.time,
                    ),
                  ),
                  SizedBox(height: 14.h),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ReactionTimeView(
                            metricType: "vo2_max",
                          ),
                        ),
                      );
                    },
                    child: PlayerStatsInfo(
                      title: 'VO2 Max',
                      statusValue: metric.vo2Max.value.toString(),
                      statusValueType: metric.vo2Max.unit,
                      time: metric.vo2Max.time,
                    ),
                  ),
                  SizedBox(height: 14.h),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ReactionTimeView(
                            metricType: "weight",
                          ),
                        ),
                      );
                    },
                    child: PlayerStatsInfo(
                      title: 'Weight',
                      statusValue: metric.weight.value.toString(),
                      statusValueType: metric.weight.unit,
                      time: metric.weight.time,
                    ),
                  ),
                  SizedBox(height: 14.h),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ReactionTimeView(
                            metricType: "resting_hr",
                          ),
                        ),
                      );
                    },
                    child: PlayerStatsInfo(
                      title: 'Reaction Time',
                      statusValue: metric.reactionTime.value.toString(),
                      statusValueType: metric.reactionTime.unit,
                      time: metric.reactionTime.time,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class PlayerMetric {
  final MetricData restingHr;
  final MetricData maxHr;
  final MetricData hrv;
  final MetricData vo2Max;
  final MetricData weight;
  final MetricData reactionTime;

  PlayerMetric({
    required this.restingHr,
    required this.maxHr,
    required this.hrv,
    required this.vo2Max,
    required this.weight,
    required this.reactionTime,
  });

  factory PlayerMetric.fromJson(Map<String, dynamic> json) {
    return PlayerMetric(
      restingHr: MetricData.fromJson(json['resting_hr']),
      maxHr: MetricData.fromJson(json['max_hr']),
      hrv: MetricData.fromJson(json['hrv']),
      vo2Max: MetricData.fromJson(json['vo2_max']),
      weight: MetricData.fromJson(json['weight']),
      reactionTime: MetricData.fromJson(json['reaction_time']),
    );
  }
}

class MetricData {
  final dynamic value;
  final String unit;
  final String time;

  MetricData({
    required this.value,
    required this.unit,
    required this.time,
  });

  factory MetricData.fromJson(Map<String, dynamic> json) {
    return MetricData(
      value: json['value'],
      unit: json['unit'],
      time: json['time'],
    );
  }
}
