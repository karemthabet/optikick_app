class AdminStatusDetail {
  final int percentage;
  final int count;

  AdminStatusDetail({required this.percentage, required this.count});

  factory AdminStatusDetail.fromJson(Map<String, dynamic> json) {
    return AdminStatusDetail(
      percentage: json['percentage'],
      count: json['count'],
    );
  }
}

class AdminStatusOverview {
  final AdminStatusDetail optimal;
  final AdminStatusDetail atRisk;
  final AdminStatusDetail underperforming;
  final AdminStatusDetail recovering;

  AdminStatusOverview({
    required this.optimal,
    required this.atRisk,
    required this.underperforming,
    required this.recovering,
  });

  factory AdminStatusOverview.fromJson(Map<String, dynamic> json) {
    final overview = json['data']['status_overview'];
    return AdminStatusOverview(
      optimal: AdminStatusDetail.fromJson(overview['Optimal']),
      atRisk: AdminStatusDetail.fromJson(overview['At Risk']),
      underperforming: AdminStatusDetail.fromJson(overview['Underperforming']),
      recovering: AdminStatusDetail.fromJson(overview['Recovering']),
    );
  }
}
