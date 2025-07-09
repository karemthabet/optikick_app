import 'dart:developer';

import 'package:dio/dio.dart';
import '../../../../core/keys/end_ponits.dart';
import '../models/graph_data_model.dart';
import 'player_metric_repo.dart';

class PlayerMetricRepoImpl implements PlayerMetricRepo {
  final Dio dio = Dio();

  @override
  Future<GraphDataModel> getPlayerMetric({
    required String mericType,
    String? period,
  }) async {
    String? periodString = period == null ? null : "?period=$period";
    try {
      final response = await dio.get(
        "${EndPoint.baseUrl}${EndPoint.metricDetails}/$mericType$periodString",
        options: Options(
          headers: {
            'Authorization': 'Bearer ${ApiKey.bearerToken}',
          },
        ),
      );
      log(response.data.toString());
      return GraphDataModel.fromJson(response.data["data"]);
    } on Exception catch (e) {
      log(e.toString());
      throw Exception('Failed to load metrics: $e');
    }
  }
}
