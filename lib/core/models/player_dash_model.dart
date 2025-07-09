class PlayerMetric {
  final double value;
  final String unit;

  PlayerMetric({required this.value, required this.unit});

  factory PlayerMetric.fromJson(Map<String, dynamic> json) {
    final dynamic rawValue = json['value'];
    return PlayerMetric(
      value: rawValue is String ? double.parse(rawValue) : rawValue.toDouble(),
      unit: json['unit'],
    );
  }
}

class DashboardPlayerMetrics {
  final PlayerMetric restingHr;
  final PlayerMetric maxHr;
  final PlayerMetric hrv;
  final PlayerMetric vo2Max;

  DashboardPlayerMetrics({
    required this.restingHr,
    required this.maxHr,
    required this.hrv,
    required this.vo2Max,
  });

  factory DashboardPlayerMetrics.fromJson(Map<String, dynamic> json) {
    final metrics = json['data']['metrics'];
    return DashboardPlayerMetrics(
      restingHr: PlayerMetric.fromJson(metrics['resting_hr']),
      maxHr: PlayerMetric.fromJson(metrics['max_hr']),
      hrv: PlayerMetric.fromJson(metrics['hrv']),
      vo2Max: PlayerMetric.fromJson(metrics['vo2_max']),
    );
  }
}
