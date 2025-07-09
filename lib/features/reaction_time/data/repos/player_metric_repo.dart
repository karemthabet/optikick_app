// import 'package:optikick/features/reaction_time/data/models/player_metric_model.dart';

import '../models/graph_data_model.dart';

abstract class PlayerMetricRepo {
  Future<GraphDataModel> getPlayerMetric({
    required String mericType,
    String? period,
  });
 
}
