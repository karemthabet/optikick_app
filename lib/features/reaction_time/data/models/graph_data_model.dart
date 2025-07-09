import 'graph_statstics_model.dart';
import 'player_model.dart';

class GraphDataModel {
  PlayerModel? player;
  String? metricType;
  String? period;
  List<GraphStasticsModel>? graphData;
  String? highlights;
  double? trend;

  GraphDataModel({
    this.player,
    this.metricType,
    this.period,
    this.graphData,
    this.highlights,
    this.trend,
  });

  factory GraphDataModel.fromJson(Map<String, dynamic> json) => GraphDataModel(
        player: json['player'] == null
            ? null
            : PlayerModel.fromJson(json['player'] as Map<String, dynamic>),
        metricType: json['metric_type'] as String?,
        period: json['period'] as String?,
        graphData: (json['graph_data'] as List<dynamic>?)
            ?.map((e) => GraphStasticsModel.fromJson(e as Map<String, dynamic>))
            .toList(),
        highlights: json["highlights"][0] as String?,
        trend: (json['trend'] as num?)?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'player': player?.toJson(),
        'metric_type': metricType,
        'period': period,
        'graph_data': graphData?.map((e) => e.toJson()).toList(),
        'highlights': highlights,
        'trend': trend,
      };
}
